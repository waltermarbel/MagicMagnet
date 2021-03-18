enum SearchState { idle, searching, finished, cancelled, error, fatalError }

extension SearchStateExtension on SearchState {
  String get message {
    switch (this) {
      case SearchState.idle:
        return 'Initializing search';
      case SearchState.searching:
        return 'Search in progress';
      case SearchState.finished:
        return 'Search finished successfully';
      case SearchState.cancelled:
        return 'Search has been cancelled';
      case SearchState.error:
        return 'An error occurred in search';
      case SearchState.fatalError:
        return 'A fatal error occurred';
      default:
        return 'Unknown state';
    }
  }
}
