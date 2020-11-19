import 'package:flutter/material.dart' hide Router;
import 'package:prephq_connect/common/colors.dart';
import 'package:prephq_connect/notifiers/mentor_meetings_nitifier.dart';
import 'package:prephq_connect/notifiers/mentor_notifier.dart';
import 'package:prephq_connect/notifiers/student_notifier.dart';
import 'package:provider/provider.dart';
import 'notifiers/student_home_notifier.dart';
import 'utils/router.dart';
import 'views/auth/login.dart';
import 'package:firebase_core/firebase_core.dart';

import 'views/mentor/home.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<StudentHomeNotifier>(
              create: (context) => StudentHomeNotifier()),
          ChangeNotifierProvider<StudentNotifier>(
              create: (context) => StudentNotifier()),
          ChangeNotifierProvider<MentorNotifier>(
              create: (context) => MentorNotifier()),
          ChangeNotifierProvider<MentorMeetingNotifier>(
              create: (context) => MentorMeetingNotifier()),    
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PrepHQ Connect',
          theme: ThemeData(
              splashColor: AppColors.primaryColor.withOpacity(0.2),
              highlightColor: Colors.transparent,
              primarySwatch: Colors.green,
              appBarTheme: AppBarTheme(
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: AppColors.mainTextColor),
                  textTheme: TextTheme(
                      headline6: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      // Side text style
                      bodyText2: TextStyle(color: Colors.black)),
                  centerTitle: true,
                  color: Colors.transparent)),
          home: LoginPage(),
          routes: Router.getRoutes(context),
        ));
  }
}