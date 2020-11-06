import 'package:flutter/material.dart';
import 'package:prephq_connect/views/user/mentor_profile_view.dart';
import 'package:prephq_connect/views/user/student_profile_view.dart';

class Router {
  static Map<String, Widget Function(BuildContext)> getRoutes(
      BuildContext cntx) {
    return {
      UserProfileView.routeName: (cntx) => UserProfileView(),
      MentorProfileView.routeName: (cntx) => MentorProfileView()
    };
  }
}
