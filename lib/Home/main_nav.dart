import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../SCREENS/auth.dart';
import '../providers/auth_p.dart';
import '../providers/course_post.dart';
import '../providers/courses.dart';
import '/SCREENS/feed.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../SCREENS/create_course.dart';
import '../SCREENS/enrolled_course.dart';
import '../SCREENS/user_home.dart';

class MainNav extends StatefulWidget {
  @override
  static const routeName = '/mainNav';
  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int pageIndex = 0;
  List<Widget> pages = [Feed(), EnrolledCourse(), UserHomeFeed()];
  var appBarTitles = ['Dashboard', 'Enrolled courses', 'Your courses'];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var profile_picture;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    print('init called');
    // Provider.of<UserProvider>(context, listen: false).signOut();
    // Provider.of<UserProvider>(context, listen: false)
    //     .getCurrentUser()
    //     .then((value) => {
    //           setState(() {
    //             isLoading = true;
    //           }),
    //           Provider.of<UserProvider>(context, listen: false)
    //               .getUser()
    //               .then((value) => {
    //                     setState(() {
    //                       // value = UserProfile(name: "", gmail: "", profile_picture: profile_picture, uid: "");
    //                       profile_picture = value!.profile_picture;
    //                       isLoading = false;
    //                     })
    //                   })
    //         });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == false
        ? Scaffold(
            appBar: AppBar(
              // title: Text(appBarTitles[pageIndex]),
              backgroundColor: Theme.of(context).primaryColor,
              actions: <Widget>[
                pageIndex == 2
                    ? IconButton(
                        icon: const Icon(
                            IconData(0xe8a6, fontFamily: 'MaterialIcons')),
                        tooltip: 'User',
                        onPressed: () async {
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .signOut();
                          Provider.of<CoursePostProvider>(context,
                                  listen: false)
                              .clearCoursePostProvider();
                          Provider.of<CourseProvider>(context, listen: false)
                              .clearCourseProvider();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Auth(),
                              ));
                        },
                      )
                    : Container()
              ],
            ),
            body: pages[pageIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: "Dashboard"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add), label: "Enrolled"),
                BottomNavigationBarItem(
                  icon: CircleAvatar(
                    radius: 15,
                    foregroundColor: Colors.cyan,
                  ),
                  //icon: Icon(Icons.add),
                  label: "Your courses",
                ),
              ],
              currentIndex: pageIndex,
              onTap: (i) {
                setState(() {
                  pageIndex = i;
                });
              },
              type: BottomNavigationBarType.fixed,
            ),
            floatingActionButton: pageIndex == 2
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CreateCourse.routeName);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  )
                : const Text(""),
          )
        : const CircularProgressIndicator();
  }
}
