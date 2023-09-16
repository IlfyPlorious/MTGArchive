part of 'cards_cubit.dart';

enum CardsListStatus { initial, loading, loadingPagination, success, failure }

extension CardsListStatusX on CardsListStatus {
  bool get isInitial => this == CardsListStatus.initial;

  bool get isLoading => this == CardsListStatus.loading;

  bool get isLoadingPagination => this == CardsListStatus.loadingPagination;

  bool get isSuccess => this == CardsListStatus.success;

  bool get isFailure => this == CardsListStatus.failure;
}

class CardsListState extends Equatable {
  CardsListState(
      {this.status = CardsListStatus.initial,
      List<Card>? cardList,
      CardsFilters? cardsFilters,
      this.currentPage = 1,
      List<Legality>? legalities,
      this.exception})
      : cardList = cardList ?? <Card>[],
        legalities = legalities ?? <Legality>[],
        cardsFilters = cardsFilters ?? CardsFilters();

  final CardsListStatus status;
  final List<Card> cardList;
  final Exception? exception;
  final int currentPage;
  final CardsFilters cardsFilters;
  final List<Legality> legalities;

  CardsListState copyWith(
      {CardsListStatus? status,
      List<Card>? cardList,
      List<Legality>? legalities,
      int? currentPage,
      CardsFilters? cardsFilters,
      Exception? exception}) {
    return CardsListState(
        status: status ?? this.status,
        cardList: cardList ?? this.cardList,
        legalities: legalities ?? this.legalities,
        currentPage: currentPage ?? this.currentPage,
        cardsFilters: cardsFilters ?? this.cardsFilters,
        exception: exception);
  }

  @override
  String toString() {
    return '\nstatus: $status\ncards: $cardList';
  }

  @override
  List<Object?> get props => [status, cardList, cardsFilters];
}
