import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/domain/entities/usecase_entity.dart';
import '../../../../core/domain/usecases/disable_usecase.dart';
import '../../../../core/domain/usecases/enable_usecase.dart';
import '../../../../core/domain/usecases/get_enabled_usecases.dart';

part 'settings_controller.g.dart';

class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  final GetEnabledUsecases _getEnabledUsecases;
  final EnableUsecase _enableUsecase;
  final DisableUsecase _disableUsecase;

  _SettingsControllerBase(
    this._getEnabledUsecases,
    this._enableUsecase,
    this._disableUsecase,
  ) {
    _getUsecases();
  }

  @observable
  var enabledUsecases = [].asObservable();

  bool hasUsecaseOfType<T>() {
    for (var usecase in enabledUsecases) {
      if (usecase.runtimeType == T) {
        return true;
      }
    }

    return false;
  }

  @action
  Future<void> enableUsecase(UsecaseEntity usecase) async {
    final result = await _enableUsecase(usecase);

    result.fold((l) => print(l), (r) {
      enabledUsecases.add(r);
      print(enabledUsecases);
    });
  }

  @action
  Future<void> disableUsecase<T>(UsecaseEntity usecase) async {
    enabledUsecases.removeWhere((element) => element.runtimeType == T);
    await _disableUsecase(usecase);
    print(enabledUsecases);
  }

  @action
  Future<void> _getUsecases() async {
    final result = await _getEnabledUsecases(NoParams());

    result.fold(
      (left) => print(left),
      (right) {
        print(right);
        enabledUsecases = right.asObservable();
      },
    );
  }
}
