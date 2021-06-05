import 'package:flutter/material.dart';

class DisableSplash extends StatelessWidget {
  DisableSplash({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowGlow();
        return true;
      },
      child: child,
    );
  }
}
