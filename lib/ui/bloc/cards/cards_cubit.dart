import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:playground/network/repository/api_service_repository.dart';
import 'package:playground/network/requestmodels/cardsrequest.dart';
import 'package:playground/utils/utils.dart';

import '../../../network/responsemodels/card.dart';

part 'cards_state.dart';

class CardsListCubit extends Cubit<CardsListState> {
  CardsListCubit()
      : _apiRepository =
            GetIt.instance<ApiServiceRepository>(instanceName: 'ApiRepository'),
        super(CardsListState());

  final ApiServiceRepository _apiRepository;

  Future<void> initData(CardsRequest cardsRequest) async {
    emit(state.copyWith(status: CardsListStatus.loading));
    try {
      final responseCards = await _apiRepository.getCards(cardsRequest);
      final responseFormats = await _apiRepository.getFormats();
      // final responseCards = await readJson();

      emit(state.copyWith(
          status: CardsListStatus.success,
          cardList: responseCards.cards,
          legalities: responseFormats.formats
              ?.map((format) =>
                  Legality(format: format, legality: LegalityValues.Legal.name))
              .toList()
            ?..insert(0,
                Legality(format: 'Any', legality: LegalityValues.Legal.name)),
          currentPage: 1));
    } on Exception catch (err) {
      emit(state.copyWith(status: CardsListStatus.failure, exception: err));
    }
  }

  Future<void> fetchCards(CardsRequest cardsRequest) async {
    emit(state.copyWith(status: CardsListStatus.loading));

    try {
      final response = await _apiRepository.getCards(cardsRequest);
      emit(state.copyWith(
          status: CardsListStatus.success,
          cardList: response.cards,
          currentPage: 1));
    } on Exception catch (err) {
      emit(state.copyWith(status: CardsListStatus.failure, exception: err));
    }
  }

  Future<void> appendCards(CardsRequest cardsRequest) async {
    if (!state.status.isLoadingPagination) {
      emit(state.copyWith(status: CardsListStatus.loadingPagination));

      try {
        final response = await _apiRepository
            .getCards(cardsRequest..page = state.currentPage + 1);
        final newList = <Card>[];
        newList.addAll(state.cardList);
        newList.addAll(response.cards ?? <Card>[]);

        emit(state.copyWith(
            status: CardsListStatus.success,
            currentPage: state.currentPage + 1,
            cardList: newList));
      } on Exception catch (err) {
        emit(state.copyWith(status: CardsListStatus.failure, exception: err));
      }
    }
  }

  Future<void> fetchFormats() async {
    emit(state.copyWith(status: CardsListStatus.loading));

    try {
      final response = await _apiRepository.getFormats();
      emit(state.copyWith(
          status: CardsListStatus.success,
          legalities: response.formats
              ?.map((format) =>
                  Legality(format: format, legality: LegalityValues.Legal.name))
              .toList()
            ?..insert(0,
                Legality(format: 'Any', legality: LegalityValues.Legal.name))));
    } on Exception catch (err) {
      emit(state.copyWith(status: CardsListStatus.failure, exception: err));
    }
  }

  void applyFilters(CardsFilters? cardsFilters) {
    emit(state.copyWith(status: CardsListStatus.loading));

    try {
      emit(state.copyWith(
          status: CardsListStatus.success, cardsFilters: cardsFilters));
    } on Exception catch (err) {
      emit(state.copyWith(status: CardsListStatus.failure, exception: err));
    }
  }

  CardsFilters getFilters() {
    return state.cardsFilters;
  }

  List<Card> getFilteredCardsList() => state.cardList
      .where((element) =>
          (state.cardsFilters.cmc ?? element.cmc) == element.cmc &&
          element.imageUrl != null &&
          (state.cardsFilters.layout?.apiName ?? element.layout) ==
              element.layout &&
          (state.cardsFilters.doesHaveColors(element.colors
                  ?.map((color) => Utils.colorFromString(color))
                  .toList()) ??
              false) &&
          (state.cardsFilters.doesHaveColorIdentities(element.colorIdentity
                  ?.map((color) => Utils.colorFromString(color))
                  .toList()) ??
              false) &&
          (Set.of(state.cardsFilters.types ?? <String>[])
                  .containsAll(element.types ?? <String>[]) ||
              (state.cardsFilters.types?.isEmpty ?? false)))
      .toList();

  Future<CardsResponse> readJson() async {
    final String response =
        await rootBundle.loadString('assets/mock_data/card_list.json');
    final data = await json.decode(response);
    final cards = CardsResponse.fromJson(data);

    return cards;
  }
}
