import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecases/get_enabled_usecases.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final GetEnabledUsecases _getEnabledUsecases;

  _AppControllerBase(this._getEnabledUsecases) {
    _getUsecases();
  }

  @observable
  var enabledUsecases = [];

  @action
  Future<void> _getUsecases() async {
    final result = await _getEnabledUsecases(NoParams());

    result.fold(
      (left) => print(left),
      (right) {
        print(right);
        enabledUsecases = right;
      },
    );
  }
}
