part of 'add_friends_dialog_cubit.dart';

class AddFriendsDialogState extends Equatable {
  AddFriendsDialogState(
      {this.status = Status.initial,
      this.exception,
      List<FirebaseUser>? users,
      List<FirebaseUser>? friendUsers,
      List<FirebaseFriendRequest>? friendRequests,
      List<FirebaseFriendRequest>? incomingFriendRequests,
      this.onFocus = false,
      this.query = emptyString})
      : users = users?.toList() ?? <FirebaseUser>[],
        friendUsers = friendUsers?.toList() ?? <FirebaseUser>[],
        friendRequests = friendRequests?.toList() ?? <FirebaseFriendRequest>[],
        incomingFriendRequests =
            incomingFriendRequests?.toList() ?? <FirebaseFriendRequest>[];

  final Status status;
  final Exception? exception;

  final List<FirebaseUser> users;
  final List<FirebaseUser> friendUsers;
  final List<FirebaseFriendRequest> friendRequests;
  final List<FirebaseFriendRequest> incomingFriendRequests;
  final String query;
  final bool onFocus;

  Map<FirebaseUser, FriendStatus> getDisplayedUsers() {
    final users = <FirebaseUser, FriendStatus>{};

    for (var user in this
        .users
        .where((element) => element.email?.contains(query) == true)) {
      FriendStatus entryValue = FriendStatus.notFriend;
      if (friendUsers.contains(user) == true) {
        entryValue = FriendStatus.friend;
      }

      for (final friendRequest in friendRequests) {
        if (friendRequest.toUser == user.id) {
          entryValue = FriendStatus.pending;
        }
      }

      for (final friendRequest in incomingFriendRequests) {
        if (friendRequest.fromUser == user.id) {
          entryValue = FriendStatus.incoming;
        }
      }

      final entry = {user: entryValue};

      if (user.id != FirebaseAuth.instance.currentUser?.uid) {
        users.addEntries(entry.entries);
      }
    }

    return users;
  }

  AddFriendsDialogState copyWith({
    Status? status,
    Exception? exception,
    bool? onFocus,
    List<FirebaseUser>? users,
    List<FirebaseUser>? friendUsers,
    List<FirebaseFriendRequest>? friendRequests,
    List<FirebaseFriendRequest>? incomingFriendRequests,
    String? query,
  }) {
    return AddFriendsDialogState(
      status: status ?? this.status,
      users: users ?? this.users,
      onFocus: onFocus ?? this.onFocus,
      query: query ?? this.query,
      friendUsers: friendUsers ?? this.friendUsers,
      friendRequests: friendRequests ?? this.friendRequests,
      incomingFriendRequests:
          incomingFriendRequests ?? this.incomingFriendRequests,
    );
  }

  @override
  List<Object> get props =>
      [status, query, users, friendUsers, friendRequests, onFocus];
}

enum FriendStatus { friend, pending, incoming, notFriend }
