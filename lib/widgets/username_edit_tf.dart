import 'package:flutter/material.dart';
import 'package:prephq_connect/common/colors.dart';
import 'package:prephq_connect/common/text_styles.dart';
import 'package:prephq_connect/notifiers/mentor_notifier.dart';
import 'package:prephq_connect/notifiers/student_notifier.dart';
import 'package:prephq_connect/notifiers/user_notifier.dart';
import 'package:provider/provider.dart';

class UserNameTF<T> extends StatelessWidget {
   UserNameTF({Key key}) : super(key: key);
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserNotifier usertNotifier;
    if(T.toString() == "StudentNotifier"){
       usertNotifier = Provider.of<StudentNotifier>(context);
    }else{
      usertNotifier = Provider.of<MentorNotifier>(context);
    }
    
    bool isEditMode = usertNotifier.isEditMode;
    controller.text = usertNotifier.userName;

     return TextField(
       readOnly: !isEditMode,
        controller: controller,
        textAlign: TextAlign.center,
        style: CustomTextStyles.heder2Ts,
        onChanged: (value){
          usertNotifier.updatedUserName = value;
        },
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(5.0),
          hintText: usertNotifier.userName,
          enabledBorder: !isEditMode
              ? InputBorder.none
              : UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 2),
                ),
          focusedBorder: !isEditMode
              ? InputBorder.none
              : UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 2),
                ),
        ));
  }
}