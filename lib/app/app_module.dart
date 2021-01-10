import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import 'app_widget.dart';
import 'core/domain/usecases/disable_usecase.dart';
import 'core/domain/usecases/enable_usecase.dart';
import 'core/domain/usecases/get_enabled_usecases.dart';
import 'core/domain/usecases/get_preferred_theme.dart';
import 'core/domain/usecases/set_preferred_theme.dart';
import 'core/external/themes_datasource_implementation.dart';
import 'core/external/usecases_datasource_implementation.dart';
import 'core/infrastructure/repositories/themes_repository_implementation.dart';
import 'core/infrastructure/repositories/usecases_repository_implementation.dart';
import 'core/presentation/controllers/app_controller.dart';
import 'modules/home/search_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController(i(), i(), i(), i(), i(), i())),
        Bind((i) => http.Client()),
        Bind((i) => HttpClientImplementation(i())),
        Bind((i) => GoogleDataSourceImplementation(i())),
        Bind((i) => GoogleRepositoryImplementation(i())),
        Bind((i) => GetMagnetLinksFromGoogle(i())),
        Bind((i) => TPBDataSourceImplementation(i())),
        Bind((i) => TPBRepositoryImplementation(i())),
        Bind((i) => GetMagnetLinksFromTPB(i())),
        Bind((i) => I337XDataSourceImplementation(i())),
        Bind((i) => I337XRepositoryImplementation(i())),
        Bind((i) => GetMagnetLinksFrom1337X(i())),
        Bind((i) => NyaaDataSourceImplementation(i())),
        Bind((i) => NyaaRepositoryImplementation(i())),
        Bind((i) => GetMagnetLinksFromNyaa(i())),
        Bind((i) => EZTVDataSourceImplementation(i())),
        Bind((i) => EZTVRepositoryImplementation(i())),
        Bind((i) => GetMagnetLinksFromEZTV(i())),
        Bind((i) => YTSDataSourceImplementation(i())),
        Bind((i) => YTSRepositoryImplementation(i())),
        Bind((i) => GetMagnetLinksFromYTS(i())),
        Bind((i) => UsecasesDataSourceImplementation()),
        Bind((i) => UsecasesRepositoryImplementation(i())),
        Bind((i) => GetEnabledUsecases(i())),
        Bind((i) => EnableUsecase(i())),
        Bind((i) => DisableUsecase(i())),
        Bind((i) => MagnetLinkInfoDataSourceImplementation(i())),
        Bind((i) => MagnetLinkInfoRepositoryImplementation(i())),
        Bind((i) => GetInfoForMagnetLink(i())),
        Bind((i) => ThemesDataSourceImplementation()),
        Bind((i) => ThemesRepositoryImplementation(i())),
        Bind((i) => GetPreferredTheme(i())),
        Bind((i) => SetPreferredTheme(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
