import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend_request.g.dart';

@JsonSerializable()
class FirebaseFriendRequest extends Equatable {
  const FirebaseFriendRequest(
      {this.fromUser, this.toUser, this.id, this.timestamp});

  @JsonKey(name: 'from_user')
  final String? fromUser;
  @JsonKey(name: 'to_user')
  final String? toUser;
  final String? id;
  final String? timestamp;

  factory FirebaseFriendRequest.fromJson(Map<String, dynamic> json) =>
      _$FirebaseFriendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseFriendRequestToJson(this);

  @override
  List<Object?> get props => [id, fromUser, toUser, timestamp];
}
