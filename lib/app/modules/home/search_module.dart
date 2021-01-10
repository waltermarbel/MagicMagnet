import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/home_page.dart';
import 'presentation/pages/result_page.dart';
import 'presentation/pages/settings_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => HomePage()),
        ModularRouter('/result', child: (_, __) => ResultPage()),
        ModularRouter('/settings', child: (_, __) => SettingsPage()),
      ];
}
