import 'package:flutter/cupertino.dart';
import 'package:prephq_connect/models/usermodels/user.dart';

 abstract class UserNotifier with ChangeNotifier{
  User user;
  bool isEditMode = false;
  String userName;
  String updatedUserName;
  changeName(String newName);
  disableEditMode();
  changeEditableMode();
  doneUpdating();
}