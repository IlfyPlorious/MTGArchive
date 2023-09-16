import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/ApiService/firestore_service.dart';
import 'package:playground/network/repository/firestore_repository.dart';
import 'package:playground/network/responsemodels/deck.dart';
import 'package:playground/utils/constants.dart';

part 'decks_collection_state.dart';

class DecksCollectionCubit extends Cubit<DecksCollectionState> {
  DecksCollectionCubit()
      : _firestoreServiceRepository =
            GetIt.instance<FirestoreServiceRepository>(
                instanceName: 'FirestoreRepository'),
        super(DecksCollectionState());

  final FirestoreServiceRepository _firestoreServiceRepository;

  Future<void> getDecksData() async {
    emit(state.copyWith(status: Status.loading));
    try {
      final decks = await _firestoreServiceRepository.getDecksByUserId(
          FirebaseAuth.instance.currentUser?.uid ?? emptyString);
      emit(state.copyWith(status: Status.success, decks: decks));
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }

  Future<void> addDeck() async {
    await _firestoreServiceRepository.addDeckForUser(
        Deck(name: 'deck', format: 'pauper'),
        FirebaseAuth.instance.currentUser?.uid ?? emptyString);
  }
}
