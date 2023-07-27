import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CustomPageAnimation extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;

  CustomPageAnimation({
    this.child,
    this.direction = AxisDirection.right,
  }) : super(
          transitionDuration: Duration(seconds: 1),
          reverseTransitionDuration: Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  Widget buildTransition(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(begin: getBeginOffset(), end: Offset.zero)
            .animate(animation),
        child: child,
      );
  // ignore: missing_return
  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return Offset(0, 1);
        case AxisDirection.down:
        return Offset(0, -1);
        case AxisDirection.left:
        return Offset(-1, 0);
        case AxisDirection.right:
        return Offset(1, 0);
    }
  }
}
