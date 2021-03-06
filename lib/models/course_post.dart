import 'package:flutter/foundation.dart';
import 'user_profile.dart';

class CoursePost {
  String? title = "", description = "", parentId = "", postType = "";
  var video_link;

  UserProfile? userProfile;
  CoursePost({
    @required this.postType,
    @required this.parentId,
    @required this.title,
    @required this.description,
    @required this.userProfile,
    this.video_link,
  });
}
