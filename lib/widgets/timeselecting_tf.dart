import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prephq_connect/common/colors.dart';
import 'package:prephq_connect/notifiers/mentor_notifier.dart';
import 'package:provider/provider.dart';

import 'time_picker.dart';

class TimeSelectingTf extends StatelessWidget {
  final int index;
  String text;
  final Function onChange;
  bool isEditMode;
  bool isFromTimeSlot;

  TextEditingController controller;
  //bool isEditMode;

  TimeSelectingTf({
    Key key,
    this.index,
    this.text,
    this.onChange,
    this.isEditMode = false,
    this.isFromTimeSlot = false,
  }) {
    controller = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
     controller.text = text;
    return TextField(
        onTap: () {
          if (!isEditMode) return;
          CustomTimePicker.showTimePicker(context, (date) {
            var mentorNotifier = Provider.of<MentorNotifier>(context, listen: false);
            if (isFromTimeSlot) {
              mentorNotifier.setTime(index, from: date);
            } else {
              mentorNotifier.setTime(index, to: date);
            }
            String formattedTime = DateFormat.Hm().format(date);
            controller.text =formattedTime;
          });
        },
        keyboardType: TextInputType.number,
        controller: controller,
        textAlign: TextAlign.center,
        readOnly: true,
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
