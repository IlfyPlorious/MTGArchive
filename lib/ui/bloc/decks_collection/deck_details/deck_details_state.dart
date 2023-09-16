part of 'deck_details_cubit.dart';

enum DeckDetailsStatus {
  initial,
  success,
  loading,
  loadingAutocomplete,
  failure
}

class DeckDetailsState extends Equatable {
  DeckDetailsState(
      {this.status = DeckDetailsStatus.initial,
      this.exception,
      Deck? deck,
      this.searchHasFocus = false,
      this.searchQuery = emptyString,
      List<String?>? autocompleteSuggestions,
      Map<String, List<DeckCard>>? cards,
      this.deckId = emptyString})
      : autocompleteSuggestions = autocompleteSuggestions ?? <String>[],
        cards = cards ?? {},
        deck = deck ?? Deck();

  final DeckDetailsStatus status;
  final Exception? exception;
  final String deckId;
  final Deck deck;
  final bool searchHasFocus;
  final String searchQuery;
  final List<String?> autocompleteSuggestions;
  final Map<String, List<DeckCard>> cards;

  DeckDetailsState copyWith(
      {Deck? deck,
      bool? searchHasFocus,
      String? searchQuery,
      String? deckId,
      DeckDetailsStatus? status,
      Exception? exception,
      Map<String, List<DeckCard>>? cards,
      List<String?>? autocompleteSuggestions}) {
    return DeckDetailsState(
        deckId: deckId ?? this.deckId,
        status: status ?? this.status,
        deck: deck ?? this.deck,
        cards: cards ?? this.cards,
        autocompleteSuggestions:
            autocompleteSuggestions ?? this.autocompleteSuggestions,
        searchQuery: searchQuery ?? this.searchQuery,
        searchHasFocus: searchHasFocus ?? this.searchHasFocus,
        exception: exception ?? this.exception);
  }

  @override
  List<Object> get props =>
      [status, deckId, searchQuery, deck, cards, searchHasFocus];
}
