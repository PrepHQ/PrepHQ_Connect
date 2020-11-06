import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ColumAnimator extends StatelessWidget {
  List<Widget> children;
  MainAxisAlignment mainAxisAlignment;
  CrossAxisAlignment crossAxisAlignment;
  ColumAnimator(
      {Key key,
      this.children,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment =  CrossAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        mainAxisAlignment: this.mainAxisAlignment,
        crossAxisAlignment: this.crossAxisAlignment,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              duration: const Duration(milliseconds: 500),
              child: widget,
            ),
          ),
          children: children,
        ),
      ),
    );
  }
}
