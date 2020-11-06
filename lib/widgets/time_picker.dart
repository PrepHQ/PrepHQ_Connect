import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomTimePicker {
  static void showTimePicker(
      BuildContext context, Function(DateTime dateTime) onDone) {
    DatePicker.showTimePicker(context,
        showTitleActions: true, showSecondsColumn: false, onConfirm: (date) {
      onDone(date);
    }, currentTime: DateTime.now());
  }
}
