// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleCardResponse _$SingleCardResponseFromJson(Map<String, dynamic> json) =>
    SingleCardResponse(
      card: json['card'] == null
          ? null
          : Card.fromJson(json['card'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleCardResponseToJson(SingleCardResponse instance) =>
    <String, dynamic>{
      'card': instance.card,
    };

CardsResponse _$CardsResponseFromJson(Map<String, dynamic> json) =>
    CardsResponse(
      cards: (json['cards'] as List<dynamic>?)
          ?.map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardsResponseToJson(CardsResponse instance) =>
    <String, dynamic>{
      'cards': instance.cards,
    };

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      name: json['name'] as String?,
      names:
          (json['names'] as List<dynamic>?)?.map((e) => e as String).toList(),
      manaCost: json['manaCost'] as String?,
      cmc: (json['cmc'] as num?)?.toDouble(),
      colors:
          (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      colorIdentity: (json['colorIdentity'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      type: json['type'] as String?,
      supertypes: (json['supertypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      subtypes: (json['subtypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      rarity: json['rarity'] as String?,
      set: json['set'] as String?,
      text: json['text'] as String?,
      artist: json['artist'] as String?,
      number: json['number'] as String?,
      power: json['power'] as String?,
      toughness: json['toughness'] as String?,
      layout: json['layout'] as String?,
      multiverseid: json['multiverseid'] as String?,
      imageUrl: json['imageUrl'] as String?,
      rulings: (json['rulings'] as List<dynamic>?)
          ?.map((e) => Rulings.fromJson(e as Map<String, dynamic>))
          .toList(),
      foreignNames: (json['foreignNames'] as List<dynamic>?)
          ?.map((e) => ForeignNames.fromJson(e as Map<String, dynamic>))
          .toList(),
      printings: (json['printings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      originalText: json['originalText'] as String?,
      originalType: json['originalType'] as String?,
      legalities: (json['legalities'] as List<dynamic>?)
          ?.map((e) => Legality.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'name': instance.name,
      'names': instance.names,
      'manaCost': instance.manaCost,
      'cmc': instance.cmc,
      'colors': instance.colors,
      'colorIdentity': instance.colorIdentity,
      'type': instance.type,
      'supertypes': instance.supertypes,
      'types': instance.types,
      'subtypes': instance.subtypes,
      'rarity': instance.rarity,
      'set': instance.set,
      'text': instance.text,
      'artist': instance.artist,
      'number': instance.number,
      'power': instance.power,
      'toughness': instance.toughness,
      'layout': instance.layout,
      'multiverseid': instance.multiverseid,
      'imageUrl': instance.imageUrl,
      'rulings': instance.rulings,
      'foreignNames': instance.foreignNames,
      'printings': instance.printings,
      'originalText': instance.originalText,
      'originalType': instance.originalType,
      'legalities': instance.legalities,
      'id': instance.id,
    };

Legality _$LegalityFromJson(Map<String, dynamic> json) => Legality(
      format: json['format'] as String?,
      legality: json['legality'] as String?,
    );

Map<String, dynamic> _$LegalityToJson(Legality instance) => <String, dynamic>{
      'format': instance.format,
      'legality': instance.legality,
    };

Rulings _$RulingsFromJson(Map<String, dynamic> json) => Rulings(
      date: json['date'] as String?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$RulingsToJson(Rulings instance) => <String, dynamic>{
      'date': instance.date,
      'text': instance.text,
    };

ForeignNames _$ForeignNamesFromJson(Map<String, dynamic> json) => ForeignNames(
      name: json['name'] as String?,
      language: json['language'] as String?,
      multiverseid: json['multiverseid'] as int?,
    );

Map<String, dynamic> _$ForeignNamesToJson(ForeignNames instance) =>
    <String, dynamic>{
      'name': instance.name,
      'language': instance.language,
      'multiverseid': instance.multiverseid,
    };
