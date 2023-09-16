import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/repository/api_service_repository.dart';
import 'package:playground/network/repository/firestore_repository.dart';
import 'package:playground/network/responsemodels/deck.dart';
import 'package:playground/utils/constants.dart';

part 'add_deck_state.dart';

class AddDeckCubit extends Cubit<AddDeckState> {
  AddDeckCubit()
      : _apiRepository =
            GetIt.instance<ApiServiceRepository>(instanceName: 'ApiRepository'),
        _firestoreServiceRepository =
            GetIt.instance<FirestoreServiceRepository>(
                instanceName: 'FirestoreRepository'),
        super(AddDeckState());

  final ApiServiceRepository _apiRepository;
  final FirestoreServiceRepository _firestoreServiceRepository;

  Future<void> initData() async {
    emit(state.copyWith(status: Status.loading));

    try {
      final response = await _apiRepository.getRandomCard();
      final legalities = response.legalities?.toJson() as Map<String, dynamic>;

      emit(state.copyWith(
          status: Status.success, formatsList: legalities.keys.toList()));
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }

  Future<void> createDeck() async {
    emit(state.copyWith(status: Status.loading));

    try {
      if (FirebaseAuth.instance.currentUser == null) {
        throw Exception('Current user is null');
      }

      if (state.name.isEmpty || state.format.isEmpty) {
        throw Exception('Please complete all field');
      }

      final deckId = await _firestoreServiceRepository.addDeckForUser(
          Deck(name: state.name.trim(), format: state.format.trim()),
          FirebaseAuth.instance.currentUser?.uid ?? emptyString);
      emit(state.copyWith(status: Status.success, deckId: deckId));
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }

  void updateName(String name) {
    emit(state.copyWith(status: Status.success, name: name));
  }

  void updateFormat(String? format) {
    emit(state.copyWith(status: Status.success, format: format));
  }
}
