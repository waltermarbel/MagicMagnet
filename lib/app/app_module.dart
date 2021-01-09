import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import 'app_widget.dart';
import 'core/domain/usecases/disable_usecase.dart';
import 'core/domain/usecases/enable_usecase.dart';
import 'core/domain/usecases/get_enabled_usecases.dart';
import 'core/external/usecases_datasource_implementation.dart';
import 'core/infrastructure/repositories/disable_usecase_repository_implementation.dart';
import 'core/infrastructure/repositories/enable_usecase_repository_implementation.dart';
import 'core/infrastructure/repositories/enabled_usecases_repository_implementation.dart';
import 'core/presentation/controllers/app_controller.dart';
import 'modules/home/search_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController(i(), i(), i(), i())),
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
        Bind((i) => EnabledUsecasesRepositoryImplementation(i())),
        Bind((i) => GetEnabledUsecases(i())),
        Bind((i) => EnableUsecaseRepositoryImplementation(i())),
        Bind((i) => EnableUsecase(i())),
        Bind((i) => DisableUsecaseRepositoryImplementation(i())),
        Bind((i) => DisableUsecase(i())),
        Bind((i) => MagnetLinkInfoDataSourceImplementation(i())),
        Bind((i) => MagnetLinkInfoRepositoryImplementation(i())),
        Bind((i) => GetInfoForMagnetLink(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
