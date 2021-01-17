import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/core/utils/flavors/build_flavor.dart';
import 'app/core/utils/user_interface/admob.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BuildFlavor(flavor: Flavor.free);
  FirebaseAdMob.instance.initialize(appId: AdmobCodes.appID);
  runApp(ModularApp(module: AppModule()));
}
