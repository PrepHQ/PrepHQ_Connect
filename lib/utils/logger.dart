import 'package:flutter/foundation.dart';

class Logger {
  static bool _isDebugModeShow = !kReleaseMode;
  static bool _isShowErr = true && _isDebugModeShow ;
  static bool _isShowWarings = true  && _isDebugModeShow;
  static bool _isPrints = true  && _isDebugModeShow;
  

  static void error(String err) {
    if (_isShowErr) {
      print('*************************************');
      print(err);
      print('*************************************');
    }
  }

  static void waring(String wrn) {
    if (_isShowWarings) {
      print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
      print(wrn);
      print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
    }
  }

  static void prints(String pr) {
    if (_isPrints) {
      print('-------------------------------------');
      print(pr);
      print('-------------------------------------');
    }
  }

}
