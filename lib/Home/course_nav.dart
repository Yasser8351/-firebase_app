// import 'package:firebase_app/SCREENS/teacher/add_post_in_course.dart';
// import 'package:firebase_app/SCREENS/teacher/course_home.dart';
// import 'package:firebase_app/SCREENS/teacher/enrolled_user.dart';
// import 'package:firebase_app/SCREENS/teacher/information.dart';
// import 'package:flutter/material.dart';

// import '/models/course.dart';

// class CourseNav extends StatefulWidget {
//   @override
//   static const routeName = '/courseNav';

//   const CourseNav({Key? key}) : super(key: key);
//   @override
//   _CourseNavState createState() => _CourseNavState();
// }

// class _CourseNavState extends State<CourseNav> {
//   @override
//   int pageIndex = 0;
//   List<Widget>? pages;
//   final bool _isLoading = false;
//   bool isAdmin = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Course? course;

//     //= ModalRoute.of(context)!.settings.arguments;

//     isAdmin = course!.isAdmin!;
//     List<dynamic>? enrolledId = course.enrolledId;
//     String? parentId = course.id;
//     List<String?> appBarTitles;
//     if (isAdmin) {
//       pages = [
//         CoursePosts(parentId),
//         CourseInformationPost(parentId),
//         EnrolledUser(enrolledId, parentId),
//         AddPostCourse(parentId),
//       ];

//       appBarTitles = [
//         course.title,
//         'Information',
//         'Enrolled users',
//         'Add post'
//       ];
//     } else {
//       pages = [
//         CoursePosts(parentId),
//         CourseInformationPost(parentId),
//       ];
//       appBarTitles = [
//         course.title,
//         'Information',
//       ];
//     }

//     return Scaffold(
//       appBar: AppBar(
//         // title: Text(appBarTitles![pageIndex]),
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: pages![pageIndex],
//       bottomNavigationBar: isAdmin
//           ? BottomNavigationBar(
//               backgroundColor: Theme.of(context).primaryColor,
//               items: const [
//                 BottomNavigationBarItem(
//                   icon: Icon(
//                     IconData(0xe871, fontFamily: 'MaterialIcons'),
//                     color: Colors.white,
//                   ),
//                   label: 'Feed',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.info_outline, color: Colors.white),
//                   label: 'Information',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.account_circle, color: Colors.white),
//                   label: 'Enrolled users',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(IconData(57672, fontFamily: 'MaterialIcons'),
//                       color: Colors.white),
//                   label: 'Add post',
//                 ),
//               ],
//               currentIndex: pageIndex,
//               onTap: (i) {
//                 print(i);
//                 setState(() {
//                   pageIndex = i;
//                 });
//               },
//               type: BottomNavigationBarType.fixed,
//             )
//           : BottomNavigationBar(
//               backgroundColor: Theme.of(context).primaryColor,
//               items: const [
//                 BottomNavigationBarItem(
//                   icon: Icon(
//                     IconData(0xe871, fontFamily: 'MaterialIcons'),
//                     color: Colors.white,
//                   ),
//                   label: 'Feed',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.info_outline, color: Colors.white),
//                   label: 'Information',
//                 )
//               ],
//               currentIndex: pageIndex,
//               onTap: (i) {
//                 print(i);
//                 setState(() {
//                   pageIndex = i;
//                 });
//               },
//             ),
//     );
//   }
// }
