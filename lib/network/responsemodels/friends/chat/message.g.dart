// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseMessage _$FirebaseMessageFromJson(Map<String, dynamic> json) =>
    FirebaseMessage(
      idFrom: json['id_from'] as String?,
      idTo: json['id_to'] as String?,
      timestamp: json['timestamp'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$FirebaseMessageToJson(FirebaseMessage instance) =>
    <String, dynamic>{
      'id_from': instance.idFrom,
      'id_to': instance.idTo,
      'content': instance.content,
      'timestamp': instance.timestamp,
    };
