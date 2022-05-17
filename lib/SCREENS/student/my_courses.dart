import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'course_detail.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  static const routeName = "MyCourses";

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SizedBox(
        height: double.infinity,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Enroll_Courses")
              .doc(auth.currentUser!.uid)
              .collection("MyEnrollCourses")
              .where("student_id", isEqualTo: auth.currentUser!.email)
              .snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final data = snapshot.data!.docs;
              if (data.isEmpty) {
                return const Center(child: Text("No Course Found"));
              }
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: double.infinity,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (ctx, index) {
                      DateTime date = data[index]["Enroll_time"].toDate();
                      date.day;
                      return Card(
                        elevation: 10,
                        child: Column(children: [
                          SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: Image.asset("assets/download.jpg")),
                          Text(
                            //"title",
                            data[index]["name_video"],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            //"descripstion_video",
                            data[index]["descripstion_video"],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => CourseDetail(
                                            description: data[index]
                                                ["descripstion_video"],
                                            title: data[index]["name_video"],
                                            // title: data[index]["video_url"],
                                            url: data[index]["video_url"],
                                          )));
                                },
                                child: const Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      "view course",
                                      //data[index]["descripstion_video"],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ]),
                      );

                      // return Card(
                      //   elevation: 10,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 5),
                      //     child: Column(children: [
                      //       const SizedBox(height: 20),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           const Text(
                      //             "course name",
                      //             style: TextStyle(
                      //                 color: Colors.black, fontSize: 18),
                      //           ),
                      //           const SizedBox(width: 20),
                      //           Text(
                      //             data[index]["course_name"],
                      //             style: const TextStyle(
                      //                 color: Colors.black, fontSize: 18),
                      //           ),
                      //         ],
                      //       ),
                      //       const SizedBox(height: 15),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           const Text(
                      //             "Enroll time",
                      //             style: TextStyle(
                      //                 color: Colors.black, fontSize: 18),
                      //           ),
                      //           const SizedBox(width: 40),
                      //           Text(
                      //             date.year.toString() +
                      //                 "/" +
                      //                 date.month.toString() +
                      //                 "/" +
                      //                 date.day.toString(),
                      //             style: const TextStyle(
                      //                 color: Colors.black, fontSize: 18),
                      //           ),
                      //         ],
                      //       ),
                      //       const SizedBox(height: 20),
                      //     ]),
                      //   ),
                      // );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
//*/

/*
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'course_detail.dart';

class MyCourses extends StatefulWidget {
  static const routeName = '/MyCourses';

  const MyCourses({Key? key}) : super(key: key);
  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  int _data = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(_data.toString());

    return Stack(
      children: [
        buildMyCourse(),
        SizedBox(
          height: double.infinity,
          child: SizedBox(
            height: double.infinity,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Enroll_Courses")
                  // .doc(auth.currentUser!.uid)
                  // .collection("MyEnrollCourses")
                  //.where("student_id", isEqualTo: auth.currentUser!.email)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final data = snapshot.data!.docs;
                  log(data.length.toString());
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: double.infinity,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (ctx, index) {
                          return Card(
                            elevation: 10,
                            child: Column(children: [
                              SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Image.asset("assets/download.jpg")),
                              Text(
                                //"title",
                                data[index]["name_video"],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                //"descripstion_video",
                                data[index]["descripstion_video"],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (ctx) => CourseDetail(
                                                    description: data[index]
                                                        ["descripstion_video"],
                                                    title: data[index]
                                                        ["name_video"],
                                                    // title: data[index]["video_url"],
                                                    url: data[index]
                                                        ["video_url"],
                                                  )));
                                    },
                                    child: const Card(
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text(
                                          "view course",
                                          //data[index]["descripstion_video"],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  // Builder(builder: (context) {
                                  //   return GestureDetector(
                                  //     onTap: () {
                                  //       enrollCourse(
                                  //         data[index]["name_video"].toString(),
                                  //         auth.currentUser!.uid,
                                  //       );
                                  //     },
                                  //     child: const Card(
                                  //       child: Padding(
                                  //         padding: EdgeInsets.all(12.0),
                                  //         child: Text(
                                  //           "Enroll",
                                  //           //data[index]["descripstion_video"],
                                  //           style: TextStyle(
                                  //               color: Color.fromARGB(
                                  //                   255, 5, 46, 122),
                                  //               fontSize: 14),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   );
                                  // }),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ]),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> enrollCourse(
    String courseName,
    String studentId,
  ) async {
    try {
      setState(() {
        isLoading = true;
      });

      FirebaseFirestore.instance
          .collection("Enroll_Courses")
          .doc(auth.currentUser!.uid)
          .collection("MyEnrollCourses")
          .doc(courseName.trim())
          .set({
        "course_name": courseName.trim(),
        "student_id": auth.currentUser!.email,
        "isEnroll": true,
        "Enroll_time": DateTime.now(),
      });
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم الاشتراك في الكورس بنجاح")));
    } on FirebaseAuthException {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("حدث خطأ اثناء الاشتراك")));
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  buildMyCourse() {
    return SizedBox(
      height: double.infinity,
      child: SizedBox(
        height: double.infinity,
        child: StreamBuilder(
          stream: getData(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text(""));
            } else {
              final data = snapshot.data!.docs;
              _data = data.length;
              if (data.isEmpty) {
                return const Center(child: Text(""));
              }
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: double.infinity,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (ctx, index) {
                      return const Text("");
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection("Enroll_Courses")
        .doc(auth.currentUser!.uid)
        .collection("MyEnrollCourses")
        .where("student_id", isEqualTo: auth.currentUser!.email)
        .snapshots();
  }
}
*/