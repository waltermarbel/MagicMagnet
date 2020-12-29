import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/utils/user_interface/app_theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      navigatorKey: Modular.navigatorKey,
      onGenerateRoute: Modular.generateRoute,
      theme: appTheme,
      title: 'Magic Magnet',
    );
  }
}
