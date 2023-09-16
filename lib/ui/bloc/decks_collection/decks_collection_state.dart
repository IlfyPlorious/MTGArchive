part of 'decks_collection_cubit.dart';

class DecksCollectionState extends Equatable {
  DecksCollectionState(
      {this.status = Status.initial, this.exception, List<Deck>? decks})
      : decks = decks ?? <Deck>[];

  final Status status;
  final Exception? exception;
  final List<Deck> decks;

  DecksCollectionState copyWith(
      {Status? status, Exception? exception, List<Deck>? decks}) {
    return DecksCollectionState(
        status: status ?? this.status,
        exception: exception ?? this.exception,
        decks: decks ?? this.decks);
  }

  @override
  List<Object?> get props => [status, decks];
}
