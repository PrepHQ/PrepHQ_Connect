import 'package:flutter/material.dart';

class CustomShadows {
   static get cardShadow => BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 1,
        blurRadius: 7,
        offset: Offset(0, 2),
      );
}
