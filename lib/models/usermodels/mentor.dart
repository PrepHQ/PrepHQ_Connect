import 'package:prephq_connect/common/databasecalls.dart';
import 'timeslots.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;
import 'user.dart';

class Mentor extends User {
  List<TimeSlots> days = [];

  @override
  getUser() async {
    Map<String, dynamic> userInfo = await getUserInfo(theUser.id);
    name = userInfo['first_name'] + ' ' + userInfo['last_name'];
    userName = email;
    imageUrl = imageURL;
    days = makeApptAvailList(userInfo['availability']);
    return this;
  }

  @override
  String toString() {
    return "${UserTypes.Mentor}";
  }

  @override
  doneUpdating() {

  }

  @override
  setName(String name) {
    this.name = name;
  }
}


