// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormatsResponse _$FormatsResponseFromJson(Map<String, dynamic> json) =>
    FormatsResponse(
      formats: (json['formats'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$FormatsResponseToJson(FormatsResponse instance) =>
    <String, dynamic>{
      'formats': instance.formats,
    };
