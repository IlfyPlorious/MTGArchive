part of 'details_cubit.dart';

enum DetailsStatus { initial, loading, success, failure }

extension DetailsStatusX on DetailsStatus {
  bool get isInitial => this == DetailsStatus.initial;

  bool get isLoading => this == DetailsStatus.loading;

  bool get isSuccess => this == DetailsStatus.success;

  bool get isFailure => this == DetailsStatus.failure;
}

class DetailsState extends Equatable {
  DetailsState(
      {this.status = DetailsStatus.initial,
      this.rulings = emptyString,
      ScryfallCard? cardDetails,
      this.exception})
      : cardDetails = cardDetails ?? ScryfallCard();

  final DetailsStatus status;
  final ScryfallCard cardDetails;
  final String rulings;
  final Exception? exception;

  DetailsState copyWith(
      {DetailsStatus? status,
      ScryfallCard? cardDetails,
      String? rulings,
      Exception? exception}) {
    return DetailsState(
        status: status ?? this.status,
        cardDetails: cardDetails ?? this.cardDetails,
        rulings: rulings ?? this.rulings,
        exception: exception);
  }

  @override
  String toString() {
    return 'Card details: $cardDetails';
  }

  @override
  List<Object> get props => [status, cardDetails, rulings];
}
