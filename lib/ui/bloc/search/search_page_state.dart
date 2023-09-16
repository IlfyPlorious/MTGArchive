part of 'search_page_cubit.dart';

enum SearchPageStatus {
  initial,
  loading,
  loadingAutocomplete,
  loadingPagination,
  success,
  failure
}

class SearchPageState extends Equatable {
  SearchPageState(
      {this.status = SearchPageStatus.initial,
      this.searchOnFocus = false,
      this.showSearchResults = false,
      this.autocompleteQuery = emptyString,
      this.exception,
      this.loadingPagination = false,
      this.page = 1,
      List<ScryfallCard>? searchResultCards,
      List<String?>? autocompleteSuggestions})
      : autocompleteSuggestions = autocompleteSuggestions ?? <String>[],
        searchResultCards = searchResultCards ?? <ScryfallCard>[];

  final SearchPageStatus status;
  final bool searchOnFocus;

  final List<String?> autocompleteSuggestions;
  final String autocompleteQuery;
  final bool showSearchResults;
  final List<ScryfallCard> searchResultCards;
  final int page;
  final bool loadingPagination;

  final Exception? exception;

  SearchPageState copyWith(
      {SearchPageStatus? status,
      bool? searchOnFocus,
      String? autocompleteQuery,
      bool? showSearchResults,
      int? page,
      bool? loadingPagination,
      List<String?>? autocompleteSuggestions,
      List<ScryfallCard>? searchResultCards,
      Exception? exception}) {
    return SearchPageState(
        status: status ?? this.status,
        searchOnFocus: searchOnFocus ?? this.searchOnFocus,
        showSearchResults: showSearchResults ?? this.showSearchResults,
        searchResultCards: searchResultCards ?? this.searchResultCards,
        page: page ?? this.page,
        loadingPagination: loadingPagination ?? this.loadingPagination,
        exception: exception ?? this.exception,
        autocompleteQuery:
            autocompleteQuery?.isNotEmpty == true && autocompleteQuery != null
                ? autocompleteQuery
                : this.autocompleteQuery,
        autocompleteSuggestions:
            autocompleteSuggestions ?? this.autocompleteSuggestions);
  }

  @override
  List<Object> get props => [
        status,
        searchOnFocus,
        autocompleteSuggestions,
        showSearchResults,
        searchResultCards,
        page,
        loadingPagination,
      ];
}
