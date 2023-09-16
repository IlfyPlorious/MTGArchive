part of 'friends_cubit.dart';

class FriendsState extends Equatable {
  FriendsState({
    this.status = Status.initial,
    this.exception,
    List<FirebaseUser>? friendsList,
    List<FirebaseFriendRequest>? receivedFriendRequests,
    List<FirebaseFriendRequest>? sentFriendRequests,
    List<FirebaseUser>? sentToUsers,
    List<FirebaseUser>? receivedFromUsers,
  })  : friendsList = friendsList ?? <FirebaseUser>[],
        receivedFriendRequests =
            receivedFriendRequests ?? <FirebaseFriendRequest>[],
        sentToUsers = sentToUsers ?? <FirebaseUser>[],
        receivedFromUsers = receivedFromUsers ?? <FirebaseUser>[],
        sentFriendRequests = sentFriendRequests ?? <FirebaseFriendRequest>[];

  final Status status;
  final Exception? exception;
  final List<FirebaseUser> friendsList;
  final List<FirebaseFriendRequest> receivedFriendRequests;
  final List<FirebaseFriendRequest> sentFriendRequests;
  final List<FirebaseUser> sentToUsers;
  final List<FirebaseUser> receivedFromUsers;

  FriendsState copyWith(
      {Status? status,
      Exception? exception,
      List<FirebaseUser>? friendsList,
      List<FirebaseFriendRequest>? receivedFriendRequests,
      List<FirebaseUser>? sentToUsers,
      List<FirebaseUser>? receivedFromUsers,
      List<FirebaseFriendRequest>? sentFriendRequests}) {
    return FriendsState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      friendsList: friendsList ?? this.friendsList,
      receivedFriendRequests:
          receivedFriendRequests ?? this.receivedFriendRequests,
      sentToUsers: sentToUsers ?? this.sentToUsers,
      receivedFromUsers: receivedFromUsers ?? this.receivedFromUsers,
      sentFriendRequests: sentFriendRequests ?? this.sentFriendRequests,
    );
  }

  @override
  List<Object> get props => [
        status,
        friendsList,
        receivedFriendRequests,
        sentFriendRequests,
        sentToUsers,
        receivedFromUsers
      ];
}
