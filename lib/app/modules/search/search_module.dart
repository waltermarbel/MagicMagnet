import 'package:flutter_modular/flutter_modular.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import 'presentation/controllers/search_controller.dart';
import 'presentation/pages/search_page.dart';

class SearchModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MagnetLinkInfoDataSourceImplementation(i())),
        Bind((i) => MagnetLinkInfoRepositoryImplementation(i())),
        Bind((i) => GetInfoForMagnetLink(i())),
        Bind((i) => SearchController(i(), i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/:content',
          child: (_, args) => SearchPage(content: args.params['content']),
        ),
      ];
}
