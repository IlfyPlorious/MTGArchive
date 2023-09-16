part of 'cards_filters_cubit.dart';

class CardsFiltersState extends Equatable {
  CardsFiltersState(
      {this.status = Status.initial, List<Legality>? legalities, this.exception})
      : legalities = legalities ?? <Legality>[];
  final Status status;
  final List<Legality> legalities;
  final Exception? exception;

  CardsFiltersState copyWith(
      {Status? status, List<Legality>? legalities, Exception? exception}) {
    return CardsFiltersState(
        status: status ?? this.status,
        legalities: legalities ?? this.legalities,
        exception: exception ?? this.exception);
  }

  @override
  String toString() {
    return 'Formats: $legalities';
  }

  @override
  List<Object?> get props => [status, legalities];
}
