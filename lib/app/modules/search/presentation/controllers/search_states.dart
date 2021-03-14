abstract class SearchState {
  final String message;

  SearchState(this.message);
}

class InitialState implements SearchState {
  @override
  String get message => 'Initializing Search';
}

class SearchingState implements SearchState {
  final String content;

  SearchingState(this.content);

  @override
  String get message => 'Searching for $content';
}

class ErrorState implements SearchState {
  final String content;

  ErrorState(this.content);

  @override
  String get message => 'An error occurred while searching for $content';
}

class FatalErrorState implements SearchState {
  @override
  String get message => 'A fatal error ocurred';
}

class FinishedState implements SearchState {
  final String content;

  FinishedState(this.content);

  @override
  String get message => 'Search for $content has been finished';
}

class CancelledSearchState implements SearchState {
  final String content;

  CancelledSearchState(this.content);

  @override
  String get message => 'The search for $content has been cancelled';
}
