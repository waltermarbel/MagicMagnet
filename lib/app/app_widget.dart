import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/settings/presentation/controllers/settings_controller.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  SettingsController settingsController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    settingsController = Modular.get<SettingsController>();
    settingsController.fetchPreferredTheme();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangePlatformBrightness() async {
    super.didChangePlatformBrightness();
    settingsController.changeAppTheme();
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
        theme: settingsController.appTheme,
        title: 'Magic Magnet',
      );
    });
  }
}
