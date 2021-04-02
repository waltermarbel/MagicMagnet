import 'package:flutter_modular/flutter_modular.dart';
import 'package:magicmagnet/app/core/domain/usecases/delete_all_custom_trackers.dart';

import '../../core/domain/usecases/disable_search_provider.dart';
import '../../core/domain/usecases/enable_search_provider.dart';
import '../../core/domain/usecases/set_custom_trackers.dart';
import 'presentation/controllers/settings_controller.dart';
import 'presentation/pages/settings_page.dart';

class SettingsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => DeleteAllCustomTrackers(i())),
        Bind((i) => EnableSearchProvider(i())),
        Bind((i) => DisableSearchProvider(i())),
        Bind((i) => SetCustomTrackers(i())),
        Bind((i) => SettingsController(i(), i(), i(), i(), i(), i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => SettingsPage()),
      ];
}
