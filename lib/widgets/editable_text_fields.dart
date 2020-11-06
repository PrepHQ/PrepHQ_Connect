import 'package:flutter/material.dart';
import 'package:prephq_connect/common/colors.dart';
import 'package:prephq_connect/notifiers/student_notifier.dart';
import 'package:provider/provider.dart';

class EditableTextField extends StatelessWidget {
  final int index;
  String text;
  final Function onChange;
  bool isEditMode;

  TextEditingController controller;
  //bool isEditMode;

  EditableTextField({
    Key key,
    this.index,
    this.text,
    this.onChange,
    this.isEditMode = false,
  }) {
    controller = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    StudentNotifier usertNotifier = Provider.of<StudentNotifier>(context);
    controller.text = text;
    return TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        textAlign: TextAlign.center,
        readOnly: !isEditMode,
        onChanged: (value) {
          usertNotifier.setScores(index, value);
        },
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(3.0),
          hintText: text,
          enabledBorder: !isEditMode
              ? InputBorder.none
              : UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 1),
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
