import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../utils/user_interface/themes.dart';
import '../repositories/themes_repository.dart';

class SetPreferredTheme implements AsyncUsecase<void, Themes> {
  final ThemesRepository repository;

  SetPreferredTheme(this.repository);

  @override
  Future<Either<Failure, void>> call(Themes newPreferredTheme) async {
    return await repository.setPreferredTheme(newPreferredTheme);
  }
}
