// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deck _$DeckFromJson(Map<String, dynamic> json) => Deck(
      id: json['id'] as String?,
      name: json['name'] as String?,
      format: json['format'] as String?,
      colors:
          (json['colors'] as List<dynamic>?)?.map((e) => e as String?).toList(),
    )..backgroundUrl = (json['background_url'] as List<dynamic>?)
        ?.map((e) => e as String?)
        .toList();

Map<String, dynamic> _$DeckToJson(Deck instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'format': instance.format,
      'colors': instance.colors,
      'background_url': instance.backgroundUrl,
    };
