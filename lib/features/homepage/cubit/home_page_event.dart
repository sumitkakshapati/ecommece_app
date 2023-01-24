abstract class HomepageEvent {}

class FetchAllHomepageDataEvent extends HomepageEvent {
  final String query;

  FetchAllHomepageDataEvent({required this.query});
}

class ReFetchAllHomepageDataEvent extends HomepageEvent {
  final String query;

  ReFetchAllHomepageDataEvent({required this.query});
}

class LoadMoreHomepageDataEvent extends HomepageEvent {
  final String query;

  LoadMoreHomepageDataEvent({required this.query});
}
