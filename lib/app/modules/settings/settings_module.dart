import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/settings_controller.dart';
import 'pages/settings_page.dart';

class SettingsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SettingsController(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => SettingsPage()),
      ];
}
