part of 'chat_cubit.dart';

class ChatState extends Equatable {
  ChatState({
    this.status = Status.initial,
    this.exception,
    FirebaseUser? corespondent,
    List<FirebaseMessage>? messagesList,
    FirebaseFriendship? friendship,
  })  : messagesList = messagesList ?? <FirebaseMessage>[],
        friendship = friendship ?? const FirebaseFriendship(),
        corespondent = corespondent ?? FirebaseUser();

  final Status status;
  final Exception? exception;
  final List<FirebaseMessage> messagesList;
  final FirebaseUser corespondent;
  final FirebaseFriendship friendship;

  ChatState copyWith({
    Status? status,
    Exception? exception,
    FirebaseUser? corespondent,
    FirebaseFriendship? friendship,
    List<FirebaseMessage>? messagesList,
  }) {
    return ChatState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      corespondent: corespondent ?? this.corespondent,
      friendship: friendship ?? this.friendship,
      messagesList: messagesList ?? this.messagesList,
    );
  }

  @override
  List<Object> get props => [status, messagesList, corespondent, friendship];
}
