import 'package:prephq_connect/models/usermodels/student.dart';
import 'package:prephq_connect/models/usermodels/student_test.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;
import 'package:prephq_connect/notifiers/user_notifier.dart';
import 'package:prephq_connect/common/databasecalls.dart';

class StudentNotifier extends UserNotifier{
  
  theUser.User user;
  bool isEditMode = false;
  bool isLoading = true;
  String userName;
  String updatedUserName;
  String profileImageUrl = "";
  List<StudentTests> tests = [];
  List<StudentTests> updatedTests = [];

  intUser(user){
    this.user = user;
  }

  disableEditMode(){
    isEditMode = false;
    notifyListeners();
  }

  changeEditableMode(){
    isEditMode = !isEditMode;
    notifyListeners();
  }

  getStudent() async {
    if(user != null) return;
    user = await Student().getUser();
    userName = user.name;
    updatedUserName = user.name;
    profileImageUrl = user.imageUrl;
    tests = (user as Student).tests;
    updatedTests = tests.map((test) =>  StudentTests(title: test.title, score: test.score, type: test.type )).toList();
    isLoading = false;
    notifyListeners();
    
  }
  

  void setScores(int index, String scores) {
    updatedTests[index].score = int.parse(scores) ;
  }

  doneUpdating() async {
    user.doneUpdating();
    userName = updatedUserName;
    this.tests = updatedTests;
    await updateStudentTests(theUser.id, tests);
    notifyListeners();
  }

  @override
  changeName(String newName) {
    this.updatedUserName = newName;
  }

  @override
  String toString() {
    return "StudentNotifier";
  }

}
