import 'package:equatable/equatable.dart';

class SearchProvider extends Equatable {
  final String key;

  SearchProvider(this.key);

  @override
  List<Object> get props => [key];
}
