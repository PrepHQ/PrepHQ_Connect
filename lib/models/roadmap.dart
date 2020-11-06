import 'package:flutter/material.dart';

class RoadMap {
  final String title;
  final IconData icon;
  bool isCompleted;
  
  RoadMap({this.title, this.isCompleted, this.icon});

  void complete() {
    isCompleted = true;
  }

  List<RoadMap> getAllRoadMaps(){
    return [
      RoadMap(
          title: "Create a profile", isCompleted: false, icon: Icons.person),
      RoadMap(
          title: 'Add 5 colleges to “my college”',
          isCompleted: false,
          icon: Icons.school),
      RoadMap(
          title: "Take SAT / ACT Exams",
          isCompleted: false,
          icon: Icons.description),
      RoadMap(
          title: "Visit campus",
          isCompleted: false,
          icon: Icons.account_balance),
      RoadMap(
          title: "Revise essay questions",
          isCompleted: false,
          icon: Icons.assignment),
      RoadMap(
          title: "Submit applications", isCompleted: false, icon: Icons.flag)
    ];
  }

}
