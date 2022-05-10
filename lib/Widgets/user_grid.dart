import 'package:flutter/material.dart';

import '/models/course.dart';
import '/models/user_profile.dart';

class ListUser extends StatelessWidget {
  @override
  UserProfile? user;
  void initState() {}

  ListUser(UserProfile tempUser) {
    user = tempUser;
  }

  @override
  Widget build(BuildContext context) {
    return (Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Center(
          child: ListTile(
        leading: CircleAvatar(
            radius: 15,
            foregroundColor: Colors.cyan,
            backgroundImage: NetworkImage(
              '${user!.profile_picture}',
            )),
        title: Text(
          '${user!.name}',
          maxLines: 1,
        ),
      )),
    ));
  }
}
