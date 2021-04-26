import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import 'app_widget.dart';
import 'core/domain/usecases/get_enabled_search_providers.dart';
import 'core/domain/usecases/get_preferred_theme.dart';
import 'core/domain/usecases/set_preferred_theme.dart';
import 'core/external/search_providers_datasource_implementation.dart';
import 'core/external/themes_datasource_implementation.dart';
import 'core/infrastructure/repositories/search_providers_repository_implementation.dart';
import 'core/infrastructure/repositories/themes_repository_implementation.dart';
import 'core/presentation/controllers/theme_controller.dart';
import 'modules/home/home_module.dart';
import 'modules/search/search_module.dart';
import 'modules/settings/settings_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => http.Client()),
        Bind((i) => HttpClientImplementation(i())),
        Bind((i) => ThemesDataSourceImplementation()),
        Bind((i) => ThemesRepositoryImplementation(i())),
        Bind((i) => GetPreferredTheme(i())),
        Bind((i) => SetPreferredTheme(i())),
        Bind((i) => ThemeController(i(), i())),
        Bind((i) => SearchProvidersDataSourceImplementation(i())),
        Bind((i) => SearchProvidersRepositoryImplementation(i())),
        Bind((i) => GetEnabledSearchProviders(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', module: HomeModule()),
        ModularRouter('/settings', module: SettingsModule()),
        ModularRouter('/search', module: SearchModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
