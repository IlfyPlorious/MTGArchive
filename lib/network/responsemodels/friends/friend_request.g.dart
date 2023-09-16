// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseFriendRequest _$FirebaseFriendRequestFromJson(
        Map<String, dynamic> json) =>
    FirebaseFriendRequest(
      fromUser: json['from_user'] as String?,
      toUser: json['to_user'] as String?,
      id: json['id'] as String?,
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$FirebaseFriendRequestToJson(
        FirebaseFriendRequest instance) =>
    <String, dynamic>{
      'from_user': instance.fromUser,
      'to_user': instance.toUser,
      'id': instance.id,
      'timestamp': instance.timestamp,
    };
