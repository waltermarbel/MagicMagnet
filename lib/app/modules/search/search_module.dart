import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/controllers/search_controller.dart';
import 'presentation/pages/result_page.dart';

class SearchModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SearchController(i(), i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/:content',
          child: (_, args) => ResultPage(content: args.params['content']),
        ),
      ];
}
