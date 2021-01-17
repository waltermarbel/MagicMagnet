import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/core/utils/flavors/build_flavor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BuildFlavor(flavor: Flavor.paid);
  runApp(ModularApp(module: AppModule()));
}
