import 'package:firebase/models/course.dart';
import 'package:firebase/models/user_profile.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import '/models/course.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class CourseProvider with ChangeNotifier {
  Course? course;
  List<Course>? feedCourse = [];
  List<Course>? userCourse = [];
  List<Course>? enrolledCourse = [];
  UserProfile? userProfile, tempUser;
  bool? requestMade = false;
  List<DocumentSnapshot>? documentSnapshots;

  CourseProvider({this.userProfile});

  Future<void> CreateCourse(String title, String description, var image) async {
    try {
      var id = userProfile!.uid;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
          path.basename(image.path);
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("course")
          .child(userProfile!.uid)
          .child(fileName);
      // final StorageReference storageReference = _storage
      //     .ref()
      //     .child("course")
      //     .child(userProfile!.uid)
      //     .child(fileName);

      Reference reference =
          _storage.ref().child("image1" + DateTime.now().toString());
      String fileUrl = await reference
          .putFile(image)
          .then((_) => reference.getDownloadURL());

      // final StorageUploadTask uploadTask = storageReference.putFile(image);

      // StorageTaskSnapshot onComplete = await uploadTask.onComplete;

      // String fileUrl = await onComplete.ref.getDownloadURL();

      var result = await firestore.collection('course').add({
        'title': title,
        'description': description,
        'coverPhoto': fileUrl,
        'createdAt': Timestamp.now(),
        'createdBy': userProfile!.uid,
        'enrolledId': [],
      });

      var courseId = result.id.toString();
      await firestore.collection('users').doc(id).update({
        'createdCourse': FieldValue.arrayUnion([courseId])
      });
      course = Course(
          id: courseId,
          title: title,
          description: description,
          coverPhoto: fileUrl,
          enrolled: false,
          isAdmin: true,
          enrolledId: [],
          userProfile: userProfile);
      userCourse!.insert(0, course!);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchCourse() async {
    try {
      requestMade = true;

      Map data, userData;
      var userSnapShot;

      print('innnnn');
      print(userProfile!.uid);
      var snap = await firestore
          .collection('course')
          .orderBy("createdAt", descending: true)
          .get();

      documentSnapshots = snap.docs;

      bool boolIsadmin, isEnrolled;
      var id, createdByid;
      List<dynamic> courseIds;
      Course temp;

      for (var key in documentSnapshots!) {
        id = key.id;
        data = key.data()!;
        createdByid = data['createdBy'];

        boolIsadmin = userProfile!.uid == createdByid;
        isEnrolled = userProfile!.enrolledCourse!.contains(id);

        if (boolIsadmin == true) {
          // print('foundddd');
          temp = Course(
              id: id,
              title: data['title'],
              description: data['description'],
              coverPhoto: data['coverPhoto'],
              enrolled: isEnrolled,
              enrolledId: data['enrolledId'],
              userProfile: userProfile,
              isAdmin: boolIsadmin);

          userCourse!.add(temp);
          print('returnedd');
          continue;
        }
        userSnapShot =
            await firestore.collection('users').doc(createdByid).get();
        userData = userSnapShot.data();
        // print('userrrr issssssssss $userData');

        tempUser = UserProfile(
            name: userData['name'],
            gmail: userData['gmail'],
            profile_picture: userData['profile_picture'],
            uid: createdByid);

        temp = Course(
            id: id,
            title: data['title'],
            description: data['description'],
            coverPhoto: data['coverPhoto'],
            enrolled: isEnrolled,
            enrolledId: data['enrolledId'],
            userProfile: tempUser,
            isAdmin: boolIsadmin);

        if (isEnrolled == true) {
          // print('uiss enrolledd');
          enrolledCourse!.add(temp);
          continue;
        }
        feedCourse!.add(temp);
      }
      notifyListeners();
    } catch (e) {
      print('error is $e');
    }
  }

  Future<void> enrollUser(Course course) async {
    String? feedId = course.id;
    await firestore.collection('users').doc(userProfile!.uid).update({
      'enrolledCourse': FieldValue.arrayUnion([feedId])
    });
    await firestore.collection('course').doc(feedId).update({
      'enrolledId': FieldValue.arrayUnion([userProfile!.uid])
    });
    feedCourse = feedCourse!.where((element) => element.id != feedId).toList();
    course.setEnrolled = true;
    enrolledCourse!.insert(0, course);
    userProfile!.setEnrolledCourse = feedId;
    notifyListeners();
  }

  void clearCourseProvider() {
    course = Course(
        id: "",
        title: "",
        description: "",
        coverPhoto: "",
        enrolled: false,
        isAdmin: false,
        enrolledId: [],
        userProfile: userProfile);
    feedCourse = [];
    userCourse = [];
    enrolledCourse = [];
    userProfile =
        UserProfile(name: "", gmail: "", profile_picture: "", uid: "");
    tempUser = UserProfile(name: "", gmail: "", profile_picture: "", uid: "");

    requestMade = false;
  }
}
