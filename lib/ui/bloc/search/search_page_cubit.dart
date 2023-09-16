import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/network/repository/api_service_repository.dart';
import 'package:playground/network/requestmodels/search_request.dart';
import 'package:playground/network/responsemodels/search_response.dart';
import 'package:playground/utils/constants.dart';

part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit()
      : _apiRepository =
            GetIt.instance<ApiServiceRepository>(instanceName: 'ApiRepository'),
        super(SearchPageState());

  final ApiServiceRepository _apiRepository;

  Future<void> getAutocompleteSuggestions(String query) async {
    emit(state.copyWith(status: SearchPageStatus.loadingAutocomplete));

    try {
      final response = await _apiRepository.getAutocompleteSuggestions(query);
      emit(state.copyWith(
          status: SearchPageStatus.success,
          autocompleteSuggestions: response.data,
          autocompleteQuery: query));
    } on Exception catch (e) {
      Logger().e(e.toString());
    }
  }

  Future<void> showSearchResults(String? query) async {
    emit(state.copyWith(status: SearchPageStatus.loading));

    try {
      final response = await _apiRepository.getSearchedCards(SearchRequest(
          page: 1,
          query: FullTextSearchQuery(name: query ?? state.autocompleteQuery),
          matchAll: {}));
      emit(state.copyWith(
          page: 1,
          status: SearchPageStatus.success,
          showSearchResults: true,
          autocompleteQuery: query,
          searchResultCards: response.data));
    } on ScryfallError catch (err) {
      Logger().e(err.getErrorMessage());
      emit(state.copyWith(status: SearchPageStatus.failure, exception: err));
    }
  }

  Future<void> loadNextPage() async {
    Logger().i('Current page: ${state.page}');
    emit(state.copyWith(
      loadingPagination: true,
      status: SearchPageStatus.loadingPagination,
    ));

    try {
      final response = await _apiRepository.getSearchedCards(SearchRequest(
          query: FullTextSearchQuery(name: state.autocompleteQuery),
          matchAll: {},
          page: state.page + 1));
      emit(state.copyWith(
          status: SearchPageStatus.success,
          page: state.page + 1,
          loadingPagination: false,
          searchResultCards: state.searchResultCards
            ..addAll(response.data ?? <ScryfallCard>[])));
    } on ScryfallError catch (err) {
      Logger().e(err.getErrorMessage());
      if (err.response?.statusCode == 422) {
        emit(state.copyWith(status: SearchPageStatus.success));
      } else {
        emit(state.copyWith(status: SearchPageStatus.failure, exception: err));
      }
    }
  }

  void changeFocus(bool onFocus) {
    emit(state.copyWith(searchOnFocus: onFocus));
  }

  void changeShowResults(bool showResults) {
    emit(state.copyWith(showSearchResults: showResults));
  }
}
