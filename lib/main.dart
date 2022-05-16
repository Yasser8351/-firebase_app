import 'package:firebase_app/SCREENS/student/login.dart';
import 'package:firebase_app/SCREENS/student/register.dart';
import 'package:firebase_app/SCREENS/student/tab_screen_student.dart';
import 'package:firebase_app/SCREENS/teacher/course_detail.dart';
import 'package:firebase_app/SCREENS/teacher/enrolled_course.dart';
import 'package:firebase_app/SCREENS/teacher/feed.dart';

import '/providers/course_post.dart';

import 'Home/main_nav.dart';
import 'package:flutter/material.dart';

import 'SCREENS/teacher/add_post_in_course.dart';
import 'SCREENS/teacher/auth.dart';
import 'SCREENS/teacher/create_course.dart';
import 'SCREENS/teacher/loading.dart';
import 'SCREENS/teacher/user_home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_p.dart';
import 'providers/courses.dart';
import 'Home/course_nav.dart';

void main() async {
  // try {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  // } catch (e) {
  //   print(e);
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProxyProvider<UserProvider, CourseProvider>(
          create: (_) => CourseProvider(),
          update: (ctx, UserProvider, previous) =>
              CourseProvider(userProfile: UserProvider.userProfile),
        ),
        ChangeNotifierProxyProvider<UserProvider, CoursePostProvider>(
          create: (_) => CoursePostProvider(),
          update: (ctx, UserProvider, previous) =>
              CoursePostProvider(userProfile: UserProvider.userProfile),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.deepPurpleAccent),
        ),
        //  home: const UploadVideo(),
        home: const Auth(),
        routes: {
          Loading.routeName: (ctx) => Loading(),
          Auth.routeName: (ctx) => const Auth(),
          CourseDetail.routeName: (ctx) => const CourseDetail(title: ""),
          CreateCourse.routeName: (ctx) => CreateCourse(),
          AddPostCourse.routeName: (ctx) => CreateCourse(),
          MainNav.routeName: (ctx) => const MainNav(),
          Login.routeName: (ctx) => const Login(),
          TabScreenStudent.routeName: (ctx) => const TabScreenStudent(),
          Register.routeName: (ctx) => const Register(),
          CourseNav.routeName: (ctx) => const CourseNav(),
          Dashboard.routeName: (ctx) => const Dashboard(),
          UserHomeFeed.routeName: (ctx) => const CourseNav(),
          EnrolledCourse.routeName: (ctx) => const CourseNav(),
        },
      ),
    );
  }
}
