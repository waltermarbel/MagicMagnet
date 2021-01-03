import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onTap;
  final Color color;

  final Widget child;
  final EdgeInsets padding;

  RoundedButton({
    @required this.child,
    @required this.onTap,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(8),
  })  : assert(child != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        focusColor: color,
        highlightColor: color,
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
