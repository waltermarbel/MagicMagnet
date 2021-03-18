import 'package:flutter_modular/flutter_modular.dart';

import '../../core/domain/usecases/disable_search_provider.dart';
import '../../core/domain/usecases/enable_search_provider.dart';
import 'presentation/controllers/settings_controller.dart';
import 'presentation/pages/settings_page.dart';

class SettingsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SettingsController(i(), i(), i())),
        Bind((i) => EnableSearchProvider(i())),
        Bind((i) => DisableSearchProvider(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => SettingsPage()),
      ];
}
