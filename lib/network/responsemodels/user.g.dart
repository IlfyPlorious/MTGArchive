// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseUser _$FirebaseUserFromJson(Map<String, dynamic> json) => FirebaseUser(
      email: json['email'] as String?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$FirebaseUserToJson(FirebaseUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'id': instance.id,
    };
