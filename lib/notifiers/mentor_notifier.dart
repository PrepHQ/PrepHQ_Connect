import 'package:flutter/material.dart';
import 'package:prephq_connect/models/usermodels/mentor.dart';
import 'package:intl/intl.dart';
import 'package:prephq_connect/models/usermodels/timeslots.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;
import 'package:prephq_connect/notifiers/user_notifier.dart';
import 'package:prephq_connect/common/databasecalls.dart';

class MentorNotifier extends UserNotifier {
  theUser.User user;
  bool isEditMode = false;
  bool isLoading = true;
  String userName;
  String updatedUserName;
  List<TimeSlots> days;
  List<TimeSlots> updatedDays;
  String profileImageUrl = "";
  intUser(user) {
    this.user = user;
  }

  @override
  disableEditMode() {
    isEditMode = false;
    notifyListeners();
  }

  @override
  changeEditableMode() {
    isEditMode = !isEditMode;
    notifyListeners();
  }

  getMentor() {
    if (user != null) return;
    user = Mentor().getUser();
    userName = user.name;
    updatedUserName = user.name;
    days = (user as Mentor).days;
    profileImageUrl = user.imageUrl;
    updatedDays = days.map((dtime) => TimeSlots(dtime.day, dtime.from, dtime.to)).toList();
    isLoading = false;
    notifyListeners();
  }

  void setTime(int index, {DateTime to , DateTime from}) {
    if(to != null){
      TimeOfDay formattedTime = TimeOfDay.fromDateTime(to);
      updatedDays[index].to = formattedTime;
    }
    if(from != null){
      TimeOfDay formattedTime = TimeOfDay.fromDateTime(from);
      updatedDays[index].from = formattedTime;
    }
  }

  @override
  doneUpdating() async {
    this.userName = updatedUserName;
    this.days = updatedDays;
    user.doneUpdating();
    await updateMentorHours(theUser.id, days);
    notifyListeners();
  }

  @override
  changeName(String newName) {
    this.updatedUserName = newName;
  }

  @override
  String toString() {
    return "MentorNotifier";
  }
}
