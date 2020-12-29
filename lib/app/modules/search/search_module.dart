import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:magic_magnet_engine/google.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import 'presentation/controllers/search_page_controller.dart';
import 'presentation/pages/result_page.dart';
import 'presentation/pages/search_page.dart';

class SearchModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SearchPageController()),
        Bind((i) => http.Client()),
        Bind((i) => HttpClientImplementation(i())),
        Bind((i) => GoogleDataSourceImplementation(i())),
        Bind((i) => GoogleRepositoryImplementation(i())),
        Bind((i) => GetMagnetLinksFromGoogle(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => SearchPage()),
        ModularRouter('/result', child: (_, __) => ResultPage()),
      ];
}
