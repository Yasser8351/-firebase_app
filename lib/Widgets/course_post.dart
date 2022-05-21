// import 'package:firebase_app/SCREENS/teacher/course_post_detail.dart';

// import '/models/course_post.dart';
// import 'package:flutter/material.dart';

// class CoursePostWidget extends StatelessWidget {
//   CoursePost? coursePost;
//   int index = 1;
//   CoursePostWidget(CoursePost coursePostParam, int indexParam) {
//     // print('cons');
//     // print(index);
//     // print('cons');
//     coursePost = coursePostParam;
//     index = indexParam + 1;
//   }
//   @override
//   Widget build(BuildContext context) {
//     print(index);
//     return Card(
//         elevation: 5,
//         margin: const EdgeInsets.all(10),
//         child: InkWell(
//           splashColor: Colors.blue.withAlpha(30),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => CoursePostDetail(coursePost!)),
//             );
//           },
//           child: Container(
//             width: double.infinity,
//             height: 50,
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('#$index',
//                     style: const TextStyle(
//                       fontSize: 20,
//                     )),
//                 Text(coursePost!.title.toString(),
//                     style: const TextStyle(
//                       fontSize: 20,
//                     )),
//               ],
//             ),
//           ),
//         ));
//   }
// }
