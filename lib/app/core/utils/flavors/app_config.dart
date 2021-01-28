import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

enum Flavor { paid, free }

class AppConfig extends InheritedWidget {
  final Flavor flavor;
  final Widget child;

  AppConfig({@required this.flavor, @required this.child});

  bool get isPaid => flavor == Flavor.paid;
  bool get isFree => flavor == Flavor.free;

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(AppConfig oldWidget) => false;
}
