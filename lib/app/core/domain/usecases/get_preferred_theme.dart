import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../utils/user_interface/themes.dart';
import '../repositories/themes_repository.dart';

class GetPreferredTheme implements AsyncUsecase<Themes, NoParams> {
  final ThemesRepository repository;

  GetPreferredTheme(this.repository);

  @override
  Future<Either<Failure, Themes>> call(NoParams params) async {
    return await repository.getPreferredTheme();
  }
}
