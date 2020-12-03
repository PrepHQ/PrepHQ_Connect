import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prephq_connect/common/colors.dart';
import 'package:prephq_connect/common/text_styles.dart';
import 'package:prephq_connect/models/meetings.dart';
import 'package:prephq_connect/notifiers/mentor_meetings_notifier.dart';
import 'package:prephq_connect/views/student/bookappointment.dart';
import 'package:prephq_connect/views/user/mentor_profile_view.dart';
import 'package:provider/provider.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;

class MentorHome extends StatefulWidget {
  MentorHome({Key key}) : super(key: key);

  @override
  _MentorHomeState createState() => _MentorHomeState();
}

class _MentorHomeState extends State<MentorHome> {
  var page = 0;

  PageController _controller = PageController(
    initialPage: 0,
  );

  List<MentorMeeting> upcomingMeetings = [];
  List<MentorMeeting> todayMeetings = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      getMeetings();
     
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onPageCgange(int index) {
    setState(() {
      page = index;
    });
  }

  forceChangePage(int index) {
    setState(() {
      _controller.jumpToPage(index);
    });
  }

  getMeetings() {
    var meetings = Provider.of<MentorMeetingNotifier>(context, listen: false);
    todayMeetings = meetings.getTodayMeetings();
    upcomingMeetings = meetings.getUpcomingMeetings();
    meetings.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Provider.of<MentorMeetingNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, MentorProfileView.routeName);
                    },
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.blueGrey,
                      backgroundImage: NetworkImage(theUser.imageURL)
                    )
                  ),
                ),
            ),
          ),
          Center(
            child: SizedBox(
              height: screenSize.height * 0.15,
              child: Image.asset(
                "assets/images/mentor_home_cover.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "My meetings ",
              style: CustomTextStyles.titleTS,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  forceChangePage(0);
                } ,
                  child: MeatingHeaderItems(
                title: "Today ",
                count: todayMeetings.length,
                isActive: page == 0,
              )),
              SizedBox(width: 75,),
              GestureDetector(
                onTap: (){
                   forceChangePage(1);
                },
                              child: MeatingHeaderItems(
                  title: "Upcoming ",
                  count: upcomingMeetings.length,
                  isActive: page == 1,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Divider(
            height: 10,
          ),
          Expanded(
              child: PageView(
            onPageChanged: onPageCgange,
            controller: _controller,
            children: [
              MeetingCard(meetings: todayMeetings,),
              MeetingCard(meetings: upcomingMeetings,),
            ],
          ))
        ],
      ),
    );
  }
}

class MeetingCard extends StatelessWidget {
  const MeetingCard({
    Key key, this.meetings,
  }) : super(key: key);

  final List<MentorMeeting> meetings;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: meetings.length,
        itemBuilder: (context, index) {
          var textStyle =
              TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);
          return ExpansionTile(
            expandedAlignment: Alignment.topRight,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meetings[index].title,
                  style: TextStyle(fontSize: 15.0),
                ),
                Text(
                    "${getDate(meetings[index].date)}",
                    style: CustomTextStyles.titleTS)
              ],
            ),
            children: <Widget>[
              Text(meetings[index].description, style: textStyle),
              Text(meetings[index].subDescription,
                  style: TextStyle(fontSize: 14.0)),
              Divider(),
              Row(
                children: [
                  Text("Start time :  "),
                  Text(
                    "${getTime(meetings[index].timeStart)}",
                    style: textStyle,
                  )
                ],
              ),
              Row(
                children: [
                  Text("End time   :  "),
                  Text(
                    "${getTime(meetings[index].timeEnd)}",
                    style: textStyle,
                  )
                ],
              )
            ],
          );
        });
  }
}

class MeatingHeaderItems extends StatelessWidget {
  const MeatingHeaderItems({
    Key key,
    this.title,
    this.count,
    this.isActive,
  }) : super(key: key);

  final String title;
  final int count;
  final isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style:
              isActive ? CustomTextStyles.activeTS : CustomTextStyles.disbleTS2,
        ),
        Container(
          padding: EdgeInsets.all(5),
          child: Text(
            "$count",
            style: TextStyle(color: AppColors.cardColor2),
          ),
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(2)),
        )
      ],
    );
  }
}
