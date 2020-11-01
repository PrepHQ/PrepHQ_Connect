import 'package:flutter/material.dart';
import 'package:prephq_connect/common/colors.dart';
import 'package:prephq_connect/common/coloum_animator.dart';
import 'package:prephq_connect/common/text_styles.dart';
import 'package:prephq_connect/models/usermodels/student_test.dart';
import 'package:prephq_connect/notifiers/student_notifier.dart';
import 'package:prephq_connect/widgets/appbar_action_btn.dart';
import 'package:prephq_connect/widgets/common/users_common.dart';
import 'package:prephq_connect/widgets/editable_text_fields.dart';
import 'package:prephq_connect/widgets/username_edit_tf.dart';
import 'package:provider/provider.dart';

class UserProfileView extends StatefulWidget {
  static final routeName = '/userProfile';
  UserProfileView({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileView> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<StudentNotifier>(context, listen: false).disableEditMode();
      Provider.of<StudentNotifier>(context, listen: false).getStudent();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StudentNotifier usertNotifier = Provider.of<StudentNotifier>(context);
    bool editMode = usertNotifier.isEditMode;

    return usertNotifier.isLoading
        ? SizedBox()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Profile"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: editMode
                      ? AppBarActionBtn(
                          onTap: () {
                            usertNotifier.changeEditableMode();
                            usertNotifier.doneUpdating();
                          },
                          icon: Icons.check,
                          iconColor: AppColors.lightIconColor,
                          btnColor: AppColors.primaryColor,
                        )
                      : AppBarActionBtn(
                          onTap: () {
                            usertNotifier.changeEditableMode();
                          },
                          icon: Icons.edit,
                          iconColor: AppColors.lightIconColor,
                          btnColor: AppColors.iconBtnColor,
                        ),
                )
              ],
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserCommons.profilePicture(
                      url: usertNotifier.profileImageUrl),
                  editMode
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: InkWell(
                              onTap: () {},
                              child: Text("upload new profile picture",
                                  style: CustomTextStyles.highlightTS)),
                        )
                      : SizedBox(),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 200.0, minWidth: 80.0),
                    child: UserNameTF<StudentNotifier>(),
                  ),
                  Padding(
                    padding: !editMode
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(top: 10),
                    child: Text('CWerth@crimson.ua.edu',
                        style: CustomTextStyles.disbleTS),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text('My Test Scores',
                        style: CustomTextStyles.title2TS),
                  ),
                  SizedBox(width: 80, child: Divider()),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: usertNotifier.tests.length,
                    padding: EdgeInsets.all(20.0),
                    itemBuilder: (context, index) {
                      var test = usertNotifier.tests[index];
                      var isMain = test.type == StudentTestsType.Main;
                      return Container(
                          color: index.isEven
                              ? AppColors.cardColor2
                              : Colors.transparent,
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(flex: 2),
                              Padding(
                                padding: EdgeInsets.only(left: isMain ? 0 : 20),
                                child: Icon(Icons.fiber_manual_record,
                                    color: AppColors.primaryColor, size: 12),
                              ),
                              SizedBox(
                                  width: 100, child: Text("  ${test.title}")),
                              Spacer(flex: 1),
                              Padding(
                                padding: EdgeInsets.only(left: isMain ? 20 : 0),
                                child: SizedBox(
                                    width: 60,
                                    child: EditableTextField(
                                      text: '${test.score}',
                                      index: index,
                                      isEditMode: usertNotifier.isEditMode,
                                    )),
                              ),
                              Spacer(flex: 2),
                            ],
                          ));
                    },
                  )
                ],
              ),
            )),
          );
  }
}
