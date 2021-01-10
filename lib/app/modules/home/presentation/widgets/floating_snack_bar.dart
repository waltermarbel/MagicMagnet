import 'package:flutter/material.dart';

class FloatingSnackBar extends StatelessWidget {
  final String text;

  const FloatingSnackBar({this.text}) : assert(text != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFF141414),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle2.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
