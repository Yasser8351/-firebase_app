// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../SCREENS/auth.dart';
// import '../SCREENS/upload_video.dart';
// import '../providers/auth_p.dart';
// import '../providers/course_post.dart';
// import '../providers/courses.dart';
// import '/SCREENS/feed.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../SCREENS/enrolled_course.dart';

// class MainNav extends StatefulWidget {
//   @override
//   static const routeName = '/mainNav';
//   @override
//   _MainNavState createState() => _MainNavState();
// }

// class _MainNavState extends State<MainNav> {
//   int pageIndex = 0;
//   List<Widget> pages = [Feed(), EnrolledCourse(), EnrolledCourse()];MainNav
//   var appBarTitles = ['Dashboard', 'Enrolled courses', 'Your courses'];
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   var profile_picture;
//   bool isLoading = false;
//   @override
//   void initState() {
//     super.initState();
//     print('init called');
//     // Provider.of<UserProvider>(context, listen: false).signOut();
//     // Provider.of<UserProvider>(context, listen: false)
//     //     .getCurrentUser()
//     //     .then((value) => {
//     //           setState(() {
//     //             isLoading = true;
//     //           }),
//     //           Provider.of<UserProvider>(context, listen: false)
//     //               .getUser()
//     //               .then((value) => {
//     //                     setState(() {
//     //                       // value = UserProfile(name: "", gmail: "", profile_picture: profile_picture, uid: "");
//     //                       profile_picture = value!.profile_picture;
//     //                       isLoading = false;
//     //                     })
//     //                   })
//     //         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading == false
//         ? Scaffold(
//             appBar: AppBar(
//               // title: Text(appBarTitles[pageIndex]),
//               backgroundColor: Theme.of(context).primaryColor,
//               actions: <Widget>[
//                 pageIndex == 2
//                     ? IconButton(
//                         icon: const Icon(
//                             IconData(0xe8a6, fontFamily: 'MaterialIcons')),
//                         tooltip: 'User',
//                         onPressed: () async {
//                           await Provider.of<UserProvider>(context,
//                                   listen: false)
//                               .signOut();
//                           Provider.of<CoursePostProvider>(context,
//                                   listen: false)
//                               .clearCoursePostProvider();
//                           Provider.of<CourseProvider>(context, listen: false)
//                               .clearCourseProvider();
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => Auth(),
//                               ));
//                         },
//                       )
//                     : Container()
//               ],
//             ),
//             body: pages[pageIndex],
//             bottomNavigationBar: BottomNavigationBar(
//               backgroundColor: Theme.of(context).primaryColor,
//               items: const [
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.dashboard), label: "Dashboard"),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.add), label: "Enrolled"),
//                 BottomNavigationBarItem(
//                   icon: CircleAvatar(
//                     radius: 15,
//                     foregroundColor: Colors.cyan,
//                     child: Text("Y"),
//                   ),
//                   //icon: Icon(Icons.add),
//                   label: "Your courses",
//                 ),
//               ],
//               currentIndex: pageIndex,
//               onTap: (i) {
//                 setState(() {
//                   pageIndex = i;
//                 });
//               },
//               type: BottomNavigationBarType.fixed,
//             ),
//             floatingActionButton: pageIndex == 2
//                 ? FloatingActionButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: ((context) {
//                         return const UploadVideo();
//                       })));
//                       // Navigator.pushNamed(context, CreateCourse.routeName);
//                     },
//                     child: const Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                     backgroundColor: Theme.of(context).primaryColor,
//                   )
//                 : const Text(""),
//           )
//         : const CircularProgressIndicator();
//   }
// }
import 'package:flutter/material.dart';

import '../SCREENS/enrolled_course.dart';
import '../SCREENS/feed.dart';
import '../SCREENS/upload_video.dart';

class MainNav extends StatefulWidget {
  const MainNav({Key? key}) : super(key: key);
  static const routeName = "MainNav";

  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  DateTime timeBackPressed = DateTime.now();
  final List<Widget> _pages = [
    Feed(),
    EnrolledCourse(),
    EnrolledCourse(),
    //   List<Widget> pages = [Feed(), EnrolledCourse(), EnrolledCourse()];MainNav
  ];
  int _currentPage = 0;
  void _selectedPage(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: WillPopScope(
              onWillPop: () async {
                final differenc = DateTime.now().difference(timeBackPressed);
                final exitApp = differenc >= const Duration(seconds: 2);

                timeBackPressed = DateTime.now();

                if (exitApp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      duration: const Duration(seconds: 2),
                      content: const Text(
                        "اضغط مرة أخري للخروج",
                        textAlign: TextAlign.right,
                      ),
                    ),
                  );
                  return false;
                } else {
                  return true;
                }
              },
              child: Scaffold(
                  body: _pages[_currentPage],
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    onTap: _selectedPage,
                    selectedItemColor: Colors.black,
                    unselectedItemColor: Colors.white,
                    currentIndex: _currentPage,
                    items: [
                      //['Dashboard', 'Enrolled courses', 'Your courses'];
                      BottomNavigationBarItem(
                        label: "Dashboard",
                        backgroundColor: Colors.white,
                        icon: Icon(
                          Icons.dashboard,
                          color:
                              _currentPage == 0 ? Colors.black : Colors.white,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: "Enrolled courses",
                        backgroundColor: Colors.white,
                        icon: Icon(
                          Icons.video_camera_back_rounded,
                          color:
                              _currentPage == 1 ? Colors.black : Colors.white,
                        ),
                      ),
                      const BottomNavigationBarItem(
                          label: "Your courses",
                          backgroundColor: Colors.white,
                          icon: CircleAvatar(
                            radius: 15,
                            foregroundColor: Colors.cyan,
                            child: Text("Y"),
                          ))
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return const UploadVideo();
                      })));
                      // Navigator.pushNamed(context, CreateCourse.routeName);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
