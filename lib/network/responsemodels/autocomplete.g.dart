// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteResponse _$AutocompleteResponseFromJson(
        Map<String, dynamic> json) =>
    AutocompleteResponse(
      object: json['object'] as String?,
      totalValues: json['total_values'] as int?,
      data: (json['data'] as List<dynamic>?)?.map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$AutocompleteResponseToJson(
        AutocompleteResponse instance) =>
    <String, dynamic>{
      'object': instance.object,
      'total_values': instance.totalValues,
      'data': instance.data,
    };
