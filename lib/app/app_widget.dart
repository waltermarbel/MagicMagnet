import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/presentation/controllers/app_controller.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  final appController = Modular.get<AppController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    appController.fetchPreferredTheme();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangePlatformBrightness() async {
    super.didChangePlatformBrightness();
    appController.changeAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        builder: asuka.builder,
        navigatorKey: Modular.navigatorKey,
        onGenerateRoute: Modular.generateRoute,
        theme: appController.appTheme,
        title: 'Magic Magnet',
      );
    });
  }
}
