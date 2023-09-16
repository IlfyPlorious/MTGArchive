import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/exceptions/exceptions.dart';
import 'package:playground/network/repository/api_service_repository.dart';
import 'package:playground/network/requestmodels/search_request.dart';
import 'package:playground/network/responsemodels/search_response.dart';

part 'advanced_search_result_page_state.dart';

class AdvancedSearchResultPageCubit
    extends Cubit<AdvancedSearchResultPageState> {
  AdvancedSearchResultPageCubit()
      : _apiRepository =
            GetIt.instance<ApiServiceRepository>(instanceName: 'ApiRepository'),
        super(AdvancedSearchResultPageState());

  final ApiServiceRepository _apiRepository;

  Future<void> initCards(SearchRequest searchRequest) async {
    emit(state.copyWith(
        status: AdvancedSearchResultPageStatus.loading,
        searchRequest: searchRequest));

    try {
      final response = await _apiRepository.getSearchedCards(searchRequest);
      emit(state.copyWith(
          status: AdvancedSearchResultPageStatus.success,
          cardList: response.data));
    } on ScryfallError catch (err) {
      Logger()
          .e('${err.getErrorMessage()}Search query: ${searchRequest.query.getFormattedQuery()}');
      emit(state.copyWith(
          status: AdvancedSearchResultPageStatus.failure, exception: err));
    }
  }

  Future<void> fetchCards() async {
    emit(state.copyWith(status: AdvancedSearchResultPageStatus.loading));

    try {
      final response =
          await _apiRepository.getSearchedCards(state.searchRequest..page = 1);
      emit(state.copyWith(
          page: 1,
          status: AdvancedSearchResultPageStatus.success,
          cardList: response.data));
    } on ScryfallError catch (err) {
      Logger().e(err.getErrorMessage());
      emit(state.copyWith(
          status: AdvancedSearchResultPageStatus.failure, exception: err));
    }
  }

  Future<void> loadNextPage() async {
    Logger().i('Current page: ${state.page}');
    emit(state.copyWith(
        status: AdvancedSearchResultPageStatus.loadingPagination,
        loadingPagination: true));

    try {
      final response = await _apiRepository
          .getSearchedCards(state.searchRequest..page = state.page + 1);
      emit(state.copyWith(
          status: AdvancedSearchResultPageStatus.success,
          loadingPagination: false,
          page: state.page + 1,
          cardList: state.cardList..addAll(response.data ?? <ScryfallCard>[])));
    } on ScryfallError catch (err) {
      Logger().e(err.getErrorMessage());
      if (err.response?.statusCode == 422) {
        emit(state.copyWith(status: AdvancedSearchResultPageStatus.success));
      } else {
        emit(state.copyWith(
            status: AdvancedSearchResultPageStatus.failure, exception: err));
      }
    }
  }
}
