import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Function onTap;
  final Widget child;

  const RoundedButton({
    this.color,
    this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        splashColor: color.withOpacity(0.8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 12.0,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
