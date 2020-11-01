import 'package:flutter/material.dart';


class AppBarActionBtn extends StatelessWidget {

  final Function onTap;
  final IconData icon;
  final Color btnColor;
  final Color iconColor;

  const AppBarActionBtn({
    Key key, this.onTap, this.icon, this.btnColor, this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: MaterialButton(
        elevation: 0.0,
        onPressed: onTap,
        color: btnColor,
        child: Icon(
          icon,
          size: 18,
          color: iconColor,
        ),
        padding: const EdgeInsets.all(5),
        shape: CircleBorder(),
      ),
    );
  }
}