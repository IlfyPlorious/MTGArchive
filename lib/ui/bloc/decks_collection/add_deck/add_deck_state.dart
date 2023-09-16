part of 'add_deck_cubit.dart';

class AddDeckState extends Equatable {
  AddDeckState({
    this.status = Status.initial,
    this.exception,
    this.name = emptyString,
    this.format = emptyString,
    this.deckId = emptyString,
    List<String>? formatsList,
  }) : formatsList = formatsList ?? <String>[];

  final Status status;
  final Exception? exception;
  final String name;
  final String format;
  final List<String> formatsList;
  final String deckId;

  AddDeckState copyWith(
      {String? name,
      String? format,
      List<String>? formatsList,
      String? deckId,
      Status? status,
      Exception? exception}) {
    return AddDeckState(
        name: name ?? this.name,
        format: format ?? this.format,
        status: status ?? this.status,
        deckId: deckId ?? this.deckId,
        formatsList: formatsList ?? this.formatsList,
        exception: exception ?? this.exception);
  }

  @override
  List<Object> get props => [status, name, format, deckId, formatsList];
}
