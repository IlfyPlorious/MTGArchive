import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/repository/api_service_repository.dart';
import 'package:playground/network/repository/firestore_repository.dart';
import 'package:playground/network/responsemodels/card.dart';
import 'package:playground/network/responsemodels/deck.dart';
import 'package:playground/network/responsemodels/firebase/deck_card.dart';
import 'package:playground/utils/constants.dart';

part 'deck_details_state.dart';

class DeckDetailsCubit extends Cubit<DeckDetailsState> {
  DeckDetailsCubit()
      : _apiRepository =
            GetIt.instance<ApiServiceRepository>(instanceName: 'ApiRepository'),
        _firestoreServiceRepository =
            GetIt.instance<FirestoreServiceRepository>(
                instanceName: 'FirestoreRepository'),
        super(DeckDetailsState());

  final ApiServiceRepository _apiRepository;
  final FirestoreServiceRepository _firestoreServiceRepository;

  Future<void> initData(String deckId) async {
    emit(state.copyWith(status: DeckDetailsStatus.loading));

    try {
      final deck = await _firestoreServiceRepository.getDeckById(
          deckId, FirebaseAuth.instance.currentUser?.uid ?? emptyString);

      final cards =
          await _firestoreServiceRepository.getCardsForDeck(deck: deck);

      emit(state.copyWith(
          status: DeckDetailsStatus.success, deck: deck, cards: cards));
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: DeckDetailsStatus.failure, exception: err));
    }
  }

  Future<void> refreshCards() async {
    try {
      final cards =
          await _firestoreServiceRepository.getCardsForDeck(deck: state.deck);

      emit(state.copyWith(
          status: DeckDetailsStatus.success,
          cards: cards,
          searchHasFocus: false));
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: DeckDetailsStatus.failure, exception: err));
    }
  }

  void changeFocus(bool hasFocus) {
    emit(state.copyWith(searchHasFocus: hasFocus));
  }

  String readSearchFocus() {
    return state.searchHasFocus.toString();
  }

  void updateSearchQuery(String value) async {
    if (value.length > 2) {
      emit(state.copyWith(status: DeckDetailsStatus.loadingAutocomplete));

      try {
        final response = await _apiRepository.getAutocompleteSuggestions(value);
        emit(state.copyWith(
            searchQuery: value,
            status: DeckDetailsStatus.success,
            autocompleteSuggestions: response.data));
      } on Exception catch (err) {
        Logger().e(err);
        emit(state.copyWith(status: DeckDetailsStatus.failure));
      }
    } else {
      emit(state.copyWith(
          status: DeckDetailsStatus.success, searchQuery: value));
    }
  }

  Future<void> addCardToDeck(
      String autocompleteSuggestion, int addCount) async {
    emit(state.copyWith(status: DeckDetailsStatus.loading));

    try {
      final cardResponse =
          await _apiRepository.getCardByName(autocompleteSuggestion);

      if (cardResponse.cardType == null) {
        throw Exception('No card type');
      }

      await _firestoreServiceRepository.addCardToDeck(
          card: cardResponse, deck: state.deck, count: addCount);

      await refreshCards();
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: DeckDetailsStatus.failure, exception: err));
    }
  }

  Future<void> removeCardsFromDeck(
      {required BaseCardTypes category,
      required DeckCard card,
      required int count}) async {
    emit(state.copyWith(status: DeckDetailsStatus.loading));

    try {
      await _firestoreServiceRepository.removeCardsFromDeck(
          category, card, state.deck, count);
      await refreshCards();
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: DeckDetailsStatus.failure, exception: err));
    }
  }

  Future<bool> deleteDeck() async {
    try {
      await _firestoreServiceRepository.deleteDeck(state.deck);
      return true;
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: DeckDetailsStatus.failure, exception: err));
      return false;
    }
  }
}
