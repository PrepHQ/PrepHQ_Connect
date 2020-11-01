import 'package:flutter/material.dart';
import 'package:prephq_connect/models/roadmap.dart';
import 'package:prephq_connect/utils/logger.dart';

class StudentHomeNotifier with ChangeNotifier {
  StudentHomeNotifier() {
    //initRoadMaps();
  }
  
  List<RoadMap> roadmaps = [];
  int completedCount = 0;
  String nextUpText = '';
  
  initRoadMaps() {
    Logger.prints('initRoadMaps' );
    roadmaps = RoadMap().getAllRoadMaps();
    changeNextUpTitle();
    notifyListeners();
  }

  didComplete(int roadMapIndex){
    roadmaps[roadMapIndex].complete();
    changeNextUpTitle();
    notifyListeners();
  }  

  changeNextUpTitle(){
     List<RoadMap> inCompleted = roadmaps.where((rm) => !rm.isCompleted ).toList();
     completedCount = roadmaps.length - inCompleted.length;
     nextUpText =  (completedCount == roadmaps.length)? "Congratulation. You have completed all steps" :  inCompleted.first.title;
  }
}
