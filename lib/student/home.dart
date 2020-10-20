import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:prephq_connect/models/roadmap.dart';
import 'package:prephq_connect/widgets/article_card.dart';
import 'package:prephq_connect/widgets/roadmap_cards.dart';

class StudentHome extends StatefulWidget {
  
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  List<RoadMap> roadmaps = [

  ];

  var completedCount = 0;

  void didCompleteRoadMap(){
    setState(() {
      completedCount += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimationLimiter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        duration: Duration(milliseconds: 1500),
                        child: widget,
                      ),
                    ),
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.blueGrey,
                              backgroundImage: NetworkImage(
                                  'https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450-300x300.jpg')),
                        ),
                      ),
                      Text('PrepHQ',
                          style: TextStyle(
                              fontSize: 35.0, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Row(
                          children: [
                            Text('my road map',
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.bold)),
                            SizedBox(width: 20.0),
                            Text('# of 6 completed',
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
                          itemCount: roadmaps.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext ctx, index) {
                            return CompletedCard(roadMap: roadmaps[index], didCompleted: didCompleteRoadMap, );
                          },
                        ),
                      ),
                      Text(
                        'next up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                iconSize: 15.0,
                                splashRadius: 20.0,
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {})
                          ],
                        ),
                      ),
                      Text('articles for you',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20.0,
                      ),
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (BuildContext ctx, index) {
                            return ArticleCard();
                          })
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
