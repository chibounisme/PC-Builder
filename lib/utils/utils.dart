import 'package:flutter/cupertino.dart';

void moveToPage(BuildContext context, Widget widget, int animationDuration) {
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(seconds: animationDuration),
          transitionsBuilder: (context, animation, animationTime, child) {
            var begin = Offset(0.0, 2);
            var end = Offset.zero;
            var curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end);
            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
          pageBuilder: (context, animation, animationTime) {
            return widget;
          }));
}
