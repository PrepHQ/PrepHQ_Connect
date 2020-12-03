String id = "";
String email = "";
String imageURL = "https://firebasestorage.googleapis.com/v0/b/prephq-connect.appspot.com/o/profilePictures%2FnoPic.png?alt=media&token=0b5e58c4-9999-4245-b9b7-6438e23f3020";
String name = "";


enum UserTypes { Student, Mentor }

abstract class User {
  String imageUrl = "";
  String name = "";
  String userName = "";
  getUser();
  setName(String name);
  doneUpdating();
}
