import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/controllers/search_page_controller.dart';
import 'presentation/pages/result_page.dart';
import 'presentation/pages/search_page.dart';

class SearchModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SearchPageController(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => SearchPage()),
        ModularRouter('/result', child: (_, __) => ResultPage()),
      ];
}
