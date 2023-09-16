import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:playground/network/repository/api_service_repository.dart';
import 'package:playground/network/responsemodels/card.dart';
import 'package:playground/utils/constants.dart';

part 'cards_filters_state.dart';

class CardsFiltersCubit extends Cubit<CardsFiltersState> {
  CardsFiltersCubit()
      : _apiRepository =
            GetIt.instance<ApiServiceRepository>(instanceName: 'ApiRepository'),
        super(CardsFiltersState());

  final ApiServiceRepository _apiRepository;

  Future<void> fetchFormats() async {
    emit(state.copyWith(status: Status.loading));

    try {
      final response = await _apiRepository.getFormats();
      emit(state.copyWith(
          status: Status.success,
          legalities: response.formats
              ?.map((format) =>
                  Legality(format: format, legality: LegalityValues.Legal.name))
              .toList()
            ?..insert(0,
                Legality(format: 'Any', legality: LegalityValues.Legal.name))));
    } on Exception catch (err) {
      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }
}
