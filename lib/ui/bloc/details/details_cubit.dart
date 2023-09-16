import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:playground/network/repository/api_service_repository.dart';
import 'package:playground/network/responsemodels/search_response.dart';
import 'package:playground/utils/constants.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit()
      : _apiRepository =
            GetIt.instance<ApiServiceRepository>(instanceName: 'ApiRepository'),
        super(DetailsState());

  final ApiServiceRepository _apiRepository;

  Future<void> fetchCardById(String id) async {
    emit(state.copyWith(status: DetailsStatus.loading));

    try {
      final card = await _apiRepository.getScryfallCardById(id);
      final rulings = await _apiRepository.getRulings(card.id!);
      emit(state.copyWith(
          status: DetailsStatus.success,
          cardDetails: card,
          rulings: rulings.data
              ?.map((ruling) => '${ruling.publishedAt}\n${ruling.comment}')
              .toList()
              .join('\n\n')));
    } on Exception catch (err) {
      emit(state.copyWith(status: DetailsStatus.failure, exception: err));
    }
  }

  Future<void> fetchCardByName(String? name) async {
    emit(state.copyWith(status: DetailsStatus.loading));

    try {
      final card = await _apiRepository.getCardByName(name!);
      final rulings = await _apiRepository.getRulings(card.id!);
      emit(state.copyWith(
          status: DetailsStatus.success,
          cardDetails: card,
          rulings: rulings.data
              ?.map((ruling) => '${ruling.publishedAt}\n${ruling.comment}')
              .toList()
              .join('\n\n')));
    } on Exception catch (err) {
      emit(state.copyWith(status: DetailsStatus.failure, exception: err));
    }
  }
}
