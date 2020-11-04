import 'package:flutter/material.dart';
import 'package:prephq_connect/common/colors.dart';
import 'package:prephq_connect/notifiers/mentor_notifier.dart';
import 'package:prephq_connect/notifiers/student_notifier.dart';
import 'package:provider/provider.dart';
import 'notifiers/student_home_notifier.dart';
import 'utils/router.dart';
import 'views/auth/login.dart';

void main() => runApp(MyApp());

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
          home: MyHomePage(),
          routes: Router.getRoutes(context),
        ));
  }
}
