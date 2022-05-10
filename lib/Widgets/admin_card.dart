import 'package:flutter/material.dart';
import '../SCREENS/course_detail.dart';
import '../SCREENS/course_home.dart';
import '../Home/course_nav.dart';
import '/models/course.dart';
// class FeedCard extends StatefulWidget {
//   @override
//   _FeedCardState createState() => _FeedCardState();
// }

// class _FeedCardState extends State<FeedCard> {
class AdminCard extends StatelessWidget {
  @override
  double borderRadius = 10, padding = 10;
  var title, description, taughtBy, coverPhoto, id;
  bool? isAdmin, enrolled;
  Course? screenArguments;
  String? finalText;
  void initState() {
    print(screenArguments);
  }

  AdminCard(Course passed) {
    screenArguments = passed;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CourseNav.routeName,
            arguments: screenArguments);
      },
      child: Container(
        width: double.infinity,
        height: 310,
        margin: EdgeInsets.all(borderRadius),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: const [
              BoxShadow(
                blurRadius: 7,
                color: Colors.grey,
                offset: Offset(0, 3),
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                  child: Image.network(
                    screenArguments!.coverPhoto.toString(),
                    fit: BoxFit.cover,
                  ),
                )),
            Padding(
              padding:
                  EdgeInsets.only(left: padding, top: padding, right: padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(screenArguments!.title.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(
                      screenArguments!.enrolledId!.isNotEmpty
                          ? '${screenArguments!.enrolledId!.length} are enrolled'
                          : 'Someone will definetly enroll',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                  SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: Theme.of(context).primaryColor,
                        splashColor: Theme.of(context).accentColor,
                        child: const Text(
                          'Go to your course',
                          style: TextStyle(color: Colors.white),
                        ),
                        textColor: Colors.blue,
                        onPressed: () {
                          Navigator.pushNamed(context, CourseNav.routeName,
                              arguments: screenArguments);
                        },
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
