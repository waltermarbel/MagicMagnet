abstract class SearchState {
  final String message;

  SearchState(this.message);
}

abstract class IdleState extends SearchState {
  IdleState(String message) : super(message);
}

abstract class ErrorState extends SearchState {
  ErrorState(String message) : super(message);
}

abstract class SuccessState extends SearchState {
  SuccessState(String message) : super(message);
}

class InitialState implements IdleState {
  @override
  String get message => 'Initializing search';
}

class SearchingContentState implements SuccessState {
  final String content;

  SearchingContentState(this.content);

  @override
  String get message => 'Searching for $content';
}

class FinishedSearchState implements SuccessState {
  final String content;

  FinishedSearchState(this.content);

  @override
  String get message => 'Search for $content has been finished';
}

class SearchErrorState implements ErrorState {
  final String content;

  SearchErrorState(this.content);

  @override
  String get message => 'An error occurred while searching for $content';
}

class FatalErrorState implements ErrorState {
  @override
  String get message => 'A fatal error ocurred';
}

class CancelledSearchState implements ErrorState {
  final String content;

  CancelledSearchState(this.content);

  @override
  String get message => 'The search for $content has been cancelled';
}
