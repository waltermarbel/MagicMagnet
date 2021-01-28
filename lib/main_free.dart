import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/core/utils/flavors/app_config.dart';
import 'app/core/utils/user_interface/admob.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: AdmobCodes.appID);

  runApp(AppConfig(
    flavor: Flavor.free,
    child: ModularApp(module: AppModule()),
  ));
}
