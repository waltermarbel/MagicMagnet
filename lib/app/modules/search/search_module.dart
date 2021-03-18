import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/controllers/search_controller.dart';
import 'presentation/pages/search_page.dart';

class SearchModule extends ChildModule {
  @override
  List<Bind> get binds => [
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
