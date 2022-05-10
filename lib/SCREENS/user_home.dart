import '/providers/courses.dart';
import 'package:flutter/material.dart';
import 'create_course.dart';
import 'package:provider/provider.dart';
import '../Widgets/admin_card.dart';

class UserHomeFeed extends StatefulWidget {
  @override
  static const routeName = '/UserHomeFeed';
  @override
  _userHomeFeedState createState() => _userHomeFeedState();
}

class _userHomeFeedState extends State<UserHomeFeed> {
  @override
  final bool _isLoading = false;
  @override
  void initState() {}
  @override
  void dispose() {
    super.dispose();
  }

  @override
  double borderRadius = 10, padding = 10;
  @override
  Widget build(BuildContext context) {
    final course = Provider.of<CourseProvider>(context);
    final courseFeed = course.userCourse;
    return courseFeed!.isNotEmpty
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
                itemCount: courseFeed.length,
                itemBuilder: (BuildContext context, i) {
                  return (AdminCard(courseFeed[i]));
                }),
          )
        : Center(
            child: Text(
              "Nothing to show",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
  }
}
