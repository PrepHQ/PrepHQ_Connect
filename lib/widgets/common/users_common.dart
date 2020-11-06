import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:prephq_connect/common/colors.dart';

class UserCommons {
  static Widget profileAvatar({double radius = 60.0, String url}) {
    return CircleAvatar(radius: 60, backgroundImage: NetworkImage(url));
  }

  static Widget profilePicture({double radius = 60.0, String url}) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          border: Border.all(
            width: 3.0,
            color: AppColors.primaryColor,
          ),
          shape: BoxShape.circle),
      child: CircleAvatar(radius: radius, backgroundImage: NetworkImage(url)),
    );
  }
}
