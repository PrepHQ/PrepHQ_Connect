import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:prephq_connect/common/column_animator.dart';
import 'package:prephq_connect/common/text_styles.dart';
import 'package:prephq_connect/notifiers/student_home_notifier.dart';
import 'package:prephq_connect/views/user/mentor_profile_view.dart';
import 'package:prephq_connect/views/user/student_profile_view.dart';
import 'package:prephq_connect/widgets/article_card.dart';
import 'package:prephq_connect/widgets/roadmap_cards.dart';
import 'package:provider/provider.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;

class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<StudentHomeNotifier>(context, listen: false).initRoadMaps();
    });
  }

  @override
  Widget build(BuildContext context) {
    StudentHomeNotifier _shNtifr = Provider.of<StudentHomeNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, UserProfileView.routeName);
                        },
                        child: CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.blueGrey,
                            backgroundImage: NetworkImage(theUser.imageURL)
                        )
                      ),
                    ),
                  ),
                  
                  Text('PrepHQ',
                      style: TextStyle(
                          fontSize: 35.0, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      children: [
                        Text('my road map', style: CustomTextStyles.titleTS),
                        SizedBox(width: 20.0),
                        Text('${_shNtifr.completedCount} of 6 completed',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey))
                      ],
                    ),
                  ),
                  Container(
                    height: 120,
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _shNtifr.roadmaps.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext ctx, index) {
                        return CompletedCard(
                          roadMap: _shNtifr.roadmaps[index],
                          index: index,
                        );
                      },
                    ),
                  ),
                  Text(
                    'next up',
                    style: CustomTextStyles.subTitleTS,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(_shNtifr.nextUpText,
                              style: TextStyle(fontWeight: FontWeight.normal)),
                        ),
                        IconButton(
                            iconSize: 15.0,
                            splashRadius: 20.0,
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {})
                      ],
                    ),
                  ),
                  Text('articles for you', style: CustomTextStyles.titleTS),
                  SizedBox(
                    height: 20.0,
                  ),
                  ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (BuildContext ctx, index) {
                        return ArticleCard();
                      }),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
