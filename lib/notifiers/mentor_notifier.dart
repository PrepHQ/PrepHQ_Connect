import 'package:prephq_connect/models/usermodels/mentor.dart';
import 'package:intl/intl.dart';
import 'package:prephq_connect/models/usermodels/timeslots.dart';
import 'package:prephq_connect/models/usermodels/user.dart';
import 'package:prephq_connect/notifiers/user_notifier.dart';

class MentorNotifier extends UserNotifier {
  User user;
  bool isEditMode = false;
  bool isLoading = true;
  String userName;
  String updatedUserName;
  List<TimeSlots> dates;
  List<TimeSlots> updatedDates;
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
    dates = (user as Mentor).dates;
    profileImageUrl = "https://upload.wikimedia.org/wikipedia/commons/e/ec/PrepGray.jpg";
    updatedDates = dates.map((dtime) => TimeSlots(dtime.date, dtime.from, dtime.to)).toList();
    isLoading = false;
    notifyListeners();
  }

  void setTime(int index, {DateTime to , DateTime from}) {
    if(to != null){
      String formattedTime = DateFormat.Hm().format(to);
      updatedDates[index].to = formattedTime;
    }
    if(from != null){
      String formattedTime = DateFormat.Hm().format(from);
      updatedDates[index].from = formattedTime;
    }
  }

  @override
  doneUpdating() {
    this.userName = updatedUserName;
    this.dates = updatedDates;
    user.doneUpdating();
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