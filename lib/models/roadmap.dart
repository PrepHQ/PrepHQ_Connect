import 'package:flutter/material.dart';

class RoadMap {
  final String title;
  final IconData icon;
  bool isCompleted;
  static int completedCount = 0;

  RoadMap({this.title, this.isCompleted, this.icon});

  void complete() {
    isCompleted = true;
    completedCount += 1;
  }
}
