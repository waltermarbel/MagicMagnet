import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../domain/entities/usecase_entity.dart';

abstract class UsecasesDataSource {
  Future<List<Usecase<Stream<MagnetLink>, SearchParameters>>>
      getEnabledUsecases();

  Future<Usecase<Stream<MagnetLink>, SearchParameters>> enableUsecase(
      UsecaseEntity usecaseEntity);

  Future<void> disableUsecase(UsecaseEntity usecaseEntity);
}
