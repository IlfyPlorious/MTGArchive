import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/repository/firestore_repository.dart';
import 'package:playground/network/responsemodels/friends/chat/message.dart';
import 'package:playground/network/responsemodels/friends/friendship.dart';
import 'package:playground/network/responsemodels/user.dart';
import 'package:playground/utils/constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : _firestoreServiceRepository =
            GetIt.instance<FirestoreServiceRepository>(
                instanceName: 'FirestoreRepository'),
        super(ChatState());

  final FirestoreServiceRepository _firestoreServiceRepository;

  Future<void> initData({required FirebaseUser corespondent}) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final friendship = await _firestoreServiceRepository.getFriendshipFor(
          FirebaseAuth.instance.currentUser?.uid ?? emptyString,
          corespondent.id ?? emptyString);

      final messagesList =
          await _firestoreServiceRepository.getChatMessages(friendship);

      emit(state.copyWith(
        status: Status.success,
        corespondent: corespondent,
        friendship: friendship,
        messagesList: messagesList,
      ));
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }

  Future<void> sendMessage(FirebaseMessage firebaseMessage) async {
    try {
      await _firestoreServiceRepository.addMessageToDatabase(
          firebaseMessage, state.friendship);

      emit(state.copyWith(status: Status.success));
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }

  Stream<QuerySnapshot> get messagesList => FirebaseFirestore.instance
      .collection('friendships')
      .doc(state.friendship.id)
      .collection('chat')
      .orderBy('timestamp')
      .snapshots();
}
