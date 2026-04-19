part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class FetchNextSearchEvent extends SearchEvent {
  const FetchNextSearchEvent();
}

class ResetFetchSearchEvent extends SearchEvent {
  const ResetFetchSearchEvent();
}

class ChangeSearchRequestSearchEvent extends SearchEvent {
  const ChangeSearchRequestSearchEvent(this.searchRequest);

  final String searchRequest;

  @override
  List<Object> get props => [searchRequest];
}
