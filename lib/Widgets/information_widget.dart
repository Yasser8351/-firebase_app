import 'package:flutter/material.dart';
import '/models/course_post.dart';
import 'package:provider/provider.dart';
import '/providers/course_post.dart';
import '/Widgets/course_post.dart';

class InformationWidget extends StatelessWidget {
  @override
  static const routeName = '/CourseInformationPost';
  CoursePost? coursePost;
  InformationWidget(CoursePost coursePostParam) {
    coursePost = coursePostParam;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                blurRadius: 7,
                color: Colors.grey,
                offset: Offset(0, 3),
              ),
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 15,
                  foregroundColor: Colors.cyan,
                  backgroundImage:
                      NetworkImage(coursePost!.userProfile!.profile_picture),
                ),
                Text(coursePost!.userProfile!.name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coursePost!.title.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  Text(coursePost!.description.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.left),
                ],
              ),
            )
          ],
        ));
  }
}
