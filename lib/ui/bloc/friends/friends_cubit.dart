import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:playground/network/repository/firestore_repository.dart';
import 'package:playground/network/responsemodels/friends/friend_request.dart';
import 'package:playground/network/responsemodels/friends/friendship.dart';
import 'package:playground/network/responsemodels/user.dart';
import 'package:playground/utils/constants.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit()
      : _firestoreServiceRepository =
            GetIt.instance<FirestoreServiceRepository>(
                instanceName: 'FirestoreRepository'),
        super(FriendsState());

  final FirestoreServiceRepository _firestoreServiceRepository;

  Future<void> initData() async {
    emit(state.copyWith(status: Status.loading));

    try {
      final sentFriendRequests =
          await _firestoreServiceRepository.getSentFriendRequestsForUser(
              FirebaseAuth.instance.currentUser?.uid ?? emptyString);
      final receivedFriendRequests =
          await _firestoreServiceRepository.getReceivedFriendRequestsForUser(
              FirebaseAuth.instance.currentUser?.uid ?? emptyString);

      final friendsList =
          await _firestoreServiceRepository.getFriendListForUser(
              FirebaseAuth.instance.currentUser?.uid ?? emptyString);

      final sentToUsers = <FirebaseUser>[];
      final receivedFromUsers = <FirebaseUser>[];

      for (final request in sentFriendRequests) {
        final toUser =
            await _firestoreServiceRepository.getUserData(request.toUser!);
        sentToUsers.add(toUser);
      }

      for (final request in receivedFriendRequests) {
        final fromUser =
            await _firestoreServiceRepository.getUserData(request.fromUser!);
        receivedFromUsers.add(fromUser);
      }

      emit(state.copyWith(
        status: Status.success,
        sentFriendRequests: sentFriendRequests,
        receivedFriendRequests: receivedFriendRequests,
        friendsList: friendsList,
        sentToUsers: sentToUsers,
        receivedFromUsers: receivedFromUsers,
      ));
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }

  Future<void> cancelFriendRequest(
      {required FirebaseUser fromUser, required FirebaseUser toUser}) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await _firestoreServiceRepository.cancelFriendRequest(
          FirebaseFriendRequest(fromUser: fromUser.id, toUser: toUser.id));

      await initData();
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }

  Future<void> acceptFriendRequest(
      FirebaseFriendRequest receivedFriendRequest) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await _firestoreServiceRepository
          .acceptFriendRequest(receivedFriendRequest);

      await initData();
      emit(state.copyWith(status: Status.success));
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }

  Future<void> removeFriend(FirebaseUser friend) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await _firestoreServiceRepository.removeFriendship(FirebaseFriendship(
          idUser1: FirebaseAuth.instance.currentUser?.uid, idUser2: friend.id));

      await initData();
    } on Exception catch (err) {
      Logger().e(err);
      emit(state.copyWith(status: Status.failure, exception: err));
    }
  }
}
