import '/providers/courses.dart';
import 'package:flutter/material.dart';
import 'create_course.dart';
import 'package:provider/provider.dart';
import '../Widgets/feed_card.dart';

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
    return courseFeed!.isNotEmpty
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
                itemCount: courseFeed.length,
                itemBuilder: (BuildContext context, i) {
                  return (FeedCard(
                    courseFeed[i],
                  ));
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
