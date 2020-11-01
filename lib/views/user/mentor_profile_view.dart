import 'package:flutter/material.dart';
import 'package:prephq_connect/common/colors.dart';
import 'package:prephq_connect/common/coloum_animator.dart';
import 'package:prephq_connect/common/text_styles.dart';
import 'package:prephq_connect/notifiers/mentor_notifier.dart';
import 'package:prephq_connect/widgets/appbar_action_btn.dart';
import 'package:prephq_connect/widgets/common/users_common.dart';
import 'package:prephq_connect/widgets/timeselecting_tf.dart';
import 'package:prephq_connect/widgets/username_edit_tf.dart';
import 'package:provider/provider.dart';

class MentorProfileView extends StatefulWidget {
  static final routeName = '/mentorProfile';
  MentorProfileView({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<MentorProfileView> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<MentorNotifier>(context, listen: false).disableEditMode();
      Provider.of<MentorNotifier>(context, listen: false).getMentor();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MentorNotifier usertNotifier = Provider.of<MentorNotifier>(context) ;
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
                  UserCommons.profilePicture(url: usertNotifier.profileImageUrl),
                  
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
                    child: UserNameTF(),
                  ),
                  Padding(
                    padding: !editMode
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(top: 10),
                    child: Text('Gray@CS.UA.EDU',
                        style: CustomTextStyles.disbleTS),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text('My daily availability',
                        style: CustomTextStyles.title2TS),
                  ),
                  SizedBox(
                      width: 80,
                      child: Divider()),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: usertNotifier.dates.length,
                    padding: EdgeInsets.all(20.0),
                    itemBuilder: (context, index) {
                      return Container(
                        color: index.isEven
                            ? AppColors.cardColor2
                            : Colors.transparent,
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  usertNotifier.dates[index].date,
                                  style: CustomTextStyles.subTitleTS,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.fiber_manual_record,
                                        color: AppColors.primaryColor,
                                        size: 12),
                                    SizedBox(
                                        width: 50,
                                        child: TimeSelectingTf(
                                          isFromTimeSlot: true,
                                          text:'${usertNotifier.dates[index].from}',
                                          index: index,
                                          isEditMode: usertNotifier.isEditMode,
                                        )),
                                    Text(" - "),
                                    SizedBox(
                                        width: 50,
                                        child: TimeSelectingTf(
                                          text:'${usertNotifier.dates[index].to}',
                                          index: index,
                                          isEditMode: usertNotifier.isEditMode,
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            )),
          );
  }
}
