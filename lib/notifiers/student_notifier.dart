import 'package:prephq_connect/models/usermodels/student.dart';
import 'package:prephq_connect/models/usermodels/student_test.dart';
import 'package:prephq_connect/models/usermodels/user.dart';
import 'package:prephq_connect/notifiers/user_notifier.dart';

class StudentNotifier extends UserNotifier{
  
  User user;
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

  getStudent(){
    if(user != null) return;
    user = Student().getUser();
    userName = user.name;
    updatedUserName = user.name;
    profileImageUrl = "https://upload.wikimedia.org/wikipedia/commons/f/fb/PrepCaleb.jpg";
    tests = (user as Student).tests;
    updatedTests = tests.map((test) =>  StudentTests(title: test.title, score: test.score, type: test.type )).toList();
    isLoading = false;
    notifyListeners();
    
  }
  

  void setScores(int index, String scores) {
    updatedTests[index].score = int.parse(scores) ;
  }

  doneUpdating(){
    user.doneUpdating();
    userName = updatedUserName;
    this.tests = updatedTests;
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
