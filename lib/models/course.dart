import 'dart:io';

import 'package:flutter/foundation.dart';
import 'user_profile.dart';

class Course {
  final String? title, description, coverPhoto, id;
  final List<dynamic>? enrolledId;
  bool? isAdmin, enrolled;
  UserProfile? userProfile;
  Course({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.coverPhoto,
    @required this.enrolled,
    @required this.isAdmin,
    @required this.enrolledId,
    @required this.userProfile,
  });
  set setEnrolled(bool value) {
    enrolled = value;
  }
}
