import 'package:cloud_firestore/cloud_firestore.dart';

import '/providers/courses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnrolledCourse extends StatefulWidget {
  @override
  static const routeName = '/EnrolledCourse';
  @override
  _enrolledCourseState createState() => _enrolledCourseState();
}

class _enrolledCourseState extends State<EnrolledCourse> {
  @override
  void dispose() {
    super.dispose();
  }

  double borderRadius = 10, padding = 10;
  @override
  Widget build(BuildContext context) {
    final course = Provider.of<CourseProvider>(context);
    final courseFeed = course.enrolledCourse;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Enroll_Courses")
              .snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final data = snapshot.data!.docs;
              return SizedBox(
                height: 777,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: ListTile(
                        title: Text(
                          data[index]["name_video"],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                        subtitle: Text(
                          data[index]["descripstion_video"],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                        leading: Image.asset("assets/download.jpg"),
                        // leading: Text(
                        //   data[index]["time"].toString(),
                        //   style: const TextStyle(
                        //       color: Colors.white, fontSize: 12),
                        //Enroll_time course_name student_id
                        // ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
    // return courseFeed!.isNotEmpty
    //     ? Container(
    //         height: double.infinity,
    //         width: double.infinity,
    //         color: Colors.white,
    //         child: ListView.builder(
    //             itemCount: courseFeed.length,
    //             itemBuilder: (BuildContext context, i) {
    //               return (FeedCard(
    //                 courseFeed[i],
    //               ));
    //             }),
    //       )
    //     : Center(
    //         child: Text(
    //           "Nothing to show",
    //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //         ),
    //       );
  }
}