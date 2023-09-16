part of 'sets_cubit.dart';

enum SetsListStatus { initial, loading, success, failure }

extension SetsListStatusX on SetsListStatus {
  bool get isInitial => this == SetsListStatus.initial;

  bool get isLoading => this == SetsListStatus.loading;

  bool get isSuccess => this == SetsListStatus.success;

  bool get isFailure => this == SetsListStatus.failure;
}

class SetsPageState extends Equatable {
  SetsPageState(
      {this.status = SetsListStatus.initial,
      List<sets_models.Set>? setsList,
      SetsFilters? setsFilters,
      this.exception})
      : setsList = setsList ?? <sets_models.Set>[],
        setsFilters = setsFilters ?? SetsFilters();

  final List<sets_models.Set> setsList;
  final SetsListStatus status;
  final Exception? exception;
  final SetsFilters setsFilters;

  SetsPageState copyWith(
      {SetsListStatus? status,
      List<sets_models.Set>? setsList,
      SetsFilters? setsFilters,
      Exception? exception}) {
    return SetsPageState(
        status: status ?? this.status,
        setsList: setsList ?? this.setsList,
        setsFilters: setsFilters ?? this.setsFilters,
        exception: exception);
  }

  @override
  String toString() {
    return '\nstatus: $status\ncards: $setsList';
  }

  @override
  List<Object?> get props => [status, setsList];
}
