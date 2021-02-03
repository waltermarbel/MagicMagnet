import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/core/utils/app_config/app_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(AppConfig(
    flavor: Flavor.paid,
    child: ModularApp(module: AppModule()),
  ));
}
