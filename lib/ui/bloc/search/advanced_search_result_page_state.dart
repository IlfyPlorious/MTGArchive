part of 'advanced_search_result_page_cubit.dart';

enum AdvancedSearchResultPageStatus {
  initial,
  loading,
  loadingPagination,
  success,
  failure
}

class AdvancedSearchResultPageState extends Equatable {
  AdvancedSearchResultPageState({
    this.status = AdvancedSearchResultPageStatus.initial,
    SearchRequest? searchRequest,
    this.page = 1,
    this.loadingPagination = false,
    List<ScryfallCard>? cardList,
    this.exception,
  })  : cardList = cardList ?? <ScryfallCard>[],
        searchRequest = searchRequest ??
            SearchRequest(
                page: 1,
                query: FullTextSearchQuery(),
                matchAll: <String, dynamic>{
                  'types': false,
                  'colors': false,
                  'rarities': false,
                  'blocks': false,
                  'sets': false,
                  'formats': false,
                  'power': '=',
                  'toughness': '=',
                  'loyalty': '=',
                  'year': '=',
                });

  final AdvancedSearchResultPageStatus status;
  final SearchRequest searchRequest;
  final int page;
  final Exception? exception;
  final List<ScryfallCard> cardList;
  final bool loadingPagination;

  AdvancedSearchResultPageState copyWith({
    AdvancedSearchResultPageStatus? status,
    SearchRequest? searchRequest,
    int? page,
    Exception? exception,
    List<ScryfallCard>? cardList,
    bool? loadingPagination,
  }) {
    return AdvancedSearchResultPageState(
        status: status ?? this.status,
        page: page ?? this.page,
        searchRequest: searchRequest ?? this.searchRequest,
        exception: exception ?? this.exception,
        loadingPagination: loadingPagination ?? this.loadingPagination,
        cardList: cardList ?? this.cardList);
  }

  @override
  List<Object> get props =>
      [status, page, cardList, searchRequest, loadingPagination];
}
