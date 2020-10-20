import 'package:flutter/material.dart';
import 'package:prephq_connect/common/colors.dart';
import 'package:prephq_connect/common/shadows.dart';
import 'package:prephq_connect/models/roadmap.dart';

// ignore: must_be_immutable
class CompletedCard extends StatefulWidget {

  final RoadMap roadMap;
  final Function didCompleted;

   CompletedCard({
    @required 
    final this.roadMap,
    @required 
    final this.didCompleted,
    Key key,
  }) : super(key: key);

  @override
  _CompletedCardState createState() => _CompletedCardState();
}

class _CompletedCardState extends State<CompletedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(boxShadow: [CustomShadows.cardShadow]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Colors.white,
          height: 100,
          width: 200,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(widget.roadMap.icon),
                    SizedBox(
                      width: 5.0,
                    ),
                    Container( width: 150, child: Text(widget.roadMap.title))
                  ],
                ),
              ),
              Spacer(),
             widget.roadMap.isCompleted ? Container(
                padding: EdgeInsets.all(2.0),
                color: AppColors.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Completed',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                  ],
                ),
              ) : Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.roadMap.complete();
                      widget.didCompleted();
                    });
                  },
                  child: new Container(   //not used outlined border cause unnecessary paddings
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: AppColors.primaryColor,
                          style: BorderStyle.solid,
                          width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                      child: Text(
                        '  Complete  ',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
