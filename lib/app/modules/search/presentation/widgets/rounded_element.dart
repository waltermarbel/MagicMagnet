import 'package:flutter/material.dart';

class RoundedElement extends StatelessWidget {
  final bool hasSplash;
  final Function onTap;
  final Widget child;

  RoundedElement({
    @required this.child,
    @required this.onTap,
    this.hasSplash = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: hasSplash ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        splashColor: hasSplash ? Color(0xFFF7F7F7) : Colors.transparent,
        hoverColor: hasSplash ? Color(0xFFF7F7F7) : Colors.transparent,
        highlightColor: hasSplash ? Color(0xFFF7F7F7) : Colors.transparent,
        focusColor: hasSplash ? Color(0xFFF7F7F7) : Colors.transparent,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: child,
        ),
      ),
    );
  }
}
