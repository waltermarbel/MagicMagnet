import 'package:equatable/equatable.dart';

class UsecaseEntity extends Equatable {
  final String key;

  UsecaseEntity(this.key);

  @override
  List<Object> get props => [key];
}
