import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import 'app_widget.dart';
import 'core/domain/usecases/get_enabled_usecases.dart';
import 'core/domain/usecases/get_preferred_theme.dart';
import 'core/domain/usecases/set_preferred_theme.dart';
import 'core/external/themes_datasource_implementation.dart';
import 'core/external/usecases_datasource_implementation.dart';
import 'core/infrastructure/repositories/themes_repository_implementation.dart';
import 'core/infrastructure/repositories/usecases_repository_implementation.dart';
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
        Bind((i) => UsecasesDataSourceImplementation(i())),
        Bind((i) => UsecasesRepositoryImplementation(i())),
        Bind((i) => GetEnabledUsecases(i())),
        Bind((i) => MagnetLinkInfoDataSourceImplementation(i())),
        Bind((i) => MagnetLinkInfoRepositoryImplementation(i())),
        Bind((i) => GetInfoForMagnetLink(i())),
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
