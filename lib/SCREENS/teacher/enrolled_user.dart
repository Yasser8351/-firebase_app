// import '/Widgets/user_grid.dart';
// import '/models/user_profile.dart';
// import '/providers/course_post.dart';
// import 'package:flutter/material.dart';
// import 'create_course.dart';
// import 'package:provider/provider.dart';

// class EnrolledUser extends StatefulWidget {
//   @override
//   static const routeName = '/EnrolledUser';
//   static List<dynamic>? enrolledId1;
//   static String? parentId1;
//   EnrolledUser(values, parentId) {
//     enrolledId1 = values;
//     parentId1 = parentId;
//   }

//   @override
//   _EnrolledUserState createState() => _EnrolledUserState();
// }

// class _EnrolledUserState extends State<EnrolledUser> {
//   @override
//   @override
//   List<dynamic>? enrolledId = EnrolledUser.enrolledId1;
//   List<UserProfile>? users;
//   String? parentId = EnrolledUser.parentId1;
//   bool _isLoading = false;
//   @override
//   void initState() {
//     super.initState();
//     print('init called $parentId');
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       _fetchUsers();
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   _fetchUsers() async {
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       print(parentId);
//       List items = Provider.of<CoursePostProvider>(context, listen: false)
//           .fetchFromProviderUserPost(parentId!);
//       print('enrollled id are ${enrolledId!.length}');
//       print('item lenth  id are ${items.length}');

//       if (items.isEmpty) {
//         await Provider.of<CoursePostProvider>(context, listen: false)
//             .fetchEnrolledUsers(enrolledId!, parentId!);
//         items = Provider.of<CoursePostProvider>(context, listen: false)
//             .fetchFromProviderUserPost(parentId!);
//       }

//       setState(() {
//         _isLoading = false;
//         users = items.cast<UserProfile>();
//       });
//     } catch (e) {
//       print('errorr iss $e');
//     }
//   }

//   @override
//   double borderRadius = 10, padding = 10;
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     /*24 is for notification bar on Android*/
//     const double itemHeight = 70;
//     final double itemWidth = size.width / 2;
//     // final course = Provider.of<CourseProvider>(context);
//     // final courseFeed = course.feedCourse;
//     return _isLoading == false
//         ? Container(
//             height: double.infinity,
//             width: double.infinity,
//             color: Colors.white,
//             child: GridView.builder(
//                 itemCount: users!.length,
//                 controller: ScrollController(keepScrollOffset: false),
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: (itemWidth / itemHeight),
//                 ),
//                 itemBuilder: (BuildContext context, i) {
//                   return (ListUser(users![i]));
//                 }),
//           )
//         : Center(child: CircularProgressIndicator());
//   }
// }
