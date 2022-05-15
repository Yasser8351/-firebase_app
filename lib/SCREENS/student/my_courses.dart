import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              .where("student_id", isEqualTo: auth.currentUser!.uid)
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(children: [
                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "course name",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  data[index]["course_name"],
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Enroll time",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                const SizedBox(width: 40),
                                Text(
                                  date.year.toString() +
                                      "/" +
                                      date.month.toString() +
                                      "/" +
                                      date.day.toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     GestureDetector(
                            //       onTap: () {
                            //         Navigator.of(context).push(MaterialPageRoute(
                            //             builder: (ctx) => CourseDetail(
                            //                   description: data[index]
                            //                       ["Enroll_time"],
                            //                   title: data[index]["course_name"],
                            //                 )));
                            //       },
                            //       child: const Card(
                            //         child: Padding(
                            //           padding: EdgeInsets.all(12.0),
                            //           child: Text(
                            //             "view course",
                            //             //data[index]["descripstion_video"],
                            //             style: TextStyle(
                            //                 color: Colors.black, fontSize: 14),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     const SizedBox(width: 15),
                            //     // Builder(builder: (context) {
                            //     //   return GestureDetector(
                            //     //     onTap: () {
                            //     //       enrollCourse(
                            //     //         data[index]["name_video"].toString(),
                            //     //         auth.currentUser!.uid,
                            //     //       );
                            //     //     },
                            //     //     child: const Card(
                            //     //       child: Padding(
                            //     //         padding: EdgeInsets.all(12.0),
                            //     //         child: Text(
                            //     //           "Enroll",
                            //     //           //data[index]["descripstion_video"],
                            //     //           style: TextStyle(
                            //     //               color:
                            //     //                   Color.fromARGB(255, 5, 46, 122),
                            //     //               fontSize: 14),
                            //     //         ),
                            //     //       ),
                            //     //     ),
                            //     //   );
                            //     // }),
                            //   ],
                            // ),
                            // const SizedBox(height: 20),
                          ]),
                        ),
                      );
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
