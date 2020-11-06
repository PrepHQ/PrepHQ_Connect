import 'package:flutter/cupertino.dart';
import 'package:prephq_connect/common/colors.dart';

class CustomTextStyles {
  static get titleTS => TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold); 
  static get title2TS => TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal); 
  static get disbleTS => TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: AppColors.secondaryTextColor); 
  static get subTitleTS => TextStyle(fontWeight: FontWeight.bold); 
  static get highlightTS => TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor);
  static get heder2Ts => TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: AppColors.mainTextColor);
}