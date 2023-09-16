import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:playground/network/repository/api_service_repository.dart';
import 'package:playground/network/requestmodels/setsrequest.dart';
import 'package:playground/network/responsemodels/sets.dart' as sets_models;

part 'sets_state.dart';

class SetsPageCubit extends Cubit<SetsPageState> {
  SetsPageCubit()
      : _apiRepository =
            GetIt.instance<ApiServiceRepository>(instanceName: 'ApiRepository'),
        super(SetsPageState());

  final ApiServiceRepository _apiRepository;

  Future<void> fetchSets(SetsRequest setsRequest) async {
    emit(state.copyWith(status: SetsListStatus.loading));

    try {
      final response = await _apiRepository.getSets(setsRequest);
      emit(state.copyWith(
          status: SetsListStatus.success, setsList: response.sets));
    } on Exception catch (err) {
      emit(state.copyWith(status: SetsListStatus.failure, exception: err));
    }
  }

  void applyFilters(SetsFilters? setsFilters) {
    emit(state.copyWith(status: SetsListStatus.loading));

    try {
      emit(state.copyWith(
          status: SetsListStatus.success, setsFilters: setsFilters));
    } on Exception catch (err) {
      emit(state.copyWith(status: SetsListStatus.failure, exception: err));
    }
  }

  SetsFilters getFilters() {
    return state.setsFilters;
  }
}
