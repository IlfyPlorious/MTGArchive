import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/repository/firestore_repository.dart';
import 'package:playground/network/responsemodels/friends/friend_request.dart';
import 'package:playground/network/responsemodels/user.dart';
import 'package:playground/utils/constants.dart';
import 'package:uuid/uuid.dart';

part 'add_friends_dialog_state.dart';

class AddFriendsDialogCubit extends Cubit<AddFriendsDialogState> {
  AddFriendsDialogCubit()
      : _firestoreServiceRepository =
            GetIt.instance<FirestoreServiceRepository>(
                instanceName: 'FirestoreRepository'),
        super(AddFriendsDialogState());

  final FirestoreServiceRepository _firestoreServiceRepository;

  Future<void> initData() async {
    emit(state.copyWith(status: Status.loading));

    try {
      final response = await _firestoreServiceRepository.getAllUsers();
      final friendRequests =
          await _firestoreServiceRepository.getSentFriendRequestsForUser(
              FirebaseAuth.instance.currentUser?.uid ?? emptyString);

      final receivedFriendRequests =
          await _firestoreServiceRepository.getReceivedFriendRequestsForUser(
              FirebaseAuth.instance.currentUser?.uid ?? emptyString);

      final friendsList =
          await _firestoreServiceRepository.getFriendListForUser(
              FirebaseAuth.instance.currentUser?.uid ?? emptyString);

      emit(state.copyWith(
          status: Status.success,
          users: response,
          friendRequests: friendRequests,
          incomingFriendRequests: receivedFriendRequests,
          friendUsers: friendsList));
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }

  void updateQuery(String query) {
    emit(state.copyWith(query: query));
  }

  void changeFocus(bool focus) {
    emit(state.copyWith(onFocus: focus));
  }

  Future<void> sendFriendRequest({required FirebaseUser toUser}) async {
    emit(state.copyWith(status: Status.loading));

    try {
      const uuid = Uuid();
      final friendRequest = FirebaseFriendRequest(
          fromUser: FirebaseAuth.instance.currentUser?.uid,
          toUser: toUser.id,
          id: uuid.v4(),
          timestamp: DateTime.now().toString());

      await _firestoreServiceRepository.sendFriendRequest(friendRequest);

      final friendRequests =
          await _firestoreServiceRepository.getSentFriendRequestsForUser(
              FirebaseAuth.instance.currentUser?.uid ?? emptyString);

      emit(state.copyWith(
          status: Status.success, friendRequests: friendRequests));
    } on Exception catch (err) {
      Logger().e(err);

      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }

  Future<void> cancelFriendRequest({required FirebaseUser toUser}) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await _firestoreServiceRepository.cancelFriendRequest(
          FirebaseFriendRequest(
              fromUser: FirebaseAuth.instance.currentUser?.uid,
              toUser: toUser.id));

      final friendRequests =
          await _firestoreServiceRepository.getSentFriendRequestsForUser(
              FirebaseAuth.instance.currentUser?.uid ?? emptyString);

      emit(state.copyWith(
          status: Status.success, friendRequests: friendRequests));
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }
}
