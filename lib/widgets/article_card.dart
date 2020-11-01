
import 'package:flutter/material.dart';
import 'package:prephq_connect/common/colors.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(
                    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Six scholerships for over \$10,000 that take under two hours to apply'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0),
                        child: SizedBox(
                          height: 25.0,
                          width: 120.0,
                          child: FlatButton(
                              color: AppColors.primaryColor
                                  .withOpacity(0.08),
                              onPressed: () {},
                              child: Text(
                                'Scholarships',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color:
                                        AppColors.primaryColor),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(height: 30, color: AppColors.mainTextColor.withOpacity(0.03),)
      ],
    );
  }
}
