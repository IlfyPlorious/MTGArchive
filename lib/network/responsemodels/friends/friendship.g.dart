// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseFriendship _$FirebaseFriendshipFromJson(Map<String, dynamic> json) =>
    FirebaseFriendship(
      idUser1: json['id_user_1'] as String?,
      idUser2: json['id_user_2'] as String?,
      id: json['id'] as String?,
      startDate: json['start_date'] as String?,
    );

Map<String, dynamic> _$FirebaseFriendshipToJson(FirebaseFriendship instance) =>
    <String, dynamic>{
      'id_user_1': instance.idUser1,
      'id_user_2': instance.idUser2,
      'id': instance.id,
      'start_date': instance.startDate,
    };
