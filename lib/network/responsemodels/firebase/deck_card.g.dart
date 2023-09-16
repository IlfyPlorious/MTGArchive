// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeckCard _$DeckCardFromJson(Map<String, dynamic> json) => DeckCard(
      count: json['count'] as int?,
    )
      ..object = json['object'] as String?
      ..id = json['id'] as String?
      ..oracleId = json['oracle_id'] as String?
      ..multiverseIds = (json['multiverse_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList()
      ..arenaId = json['arena_id'] as int?
      ..name = json['name'] as String?
      ..lang = json['lang'] as String?
      ..releasedAt = json['released_at'] as String?
      ..uri = json['uri'] as String?
      ..scryfallUri = json['scryfall_uri'] as String?
      ..layout = json['layout'] as String?
      ..highresImage = json['highres_image'] as bool?
      ..imageStatus = json['image_status'] as String?
      ..imageUris = json['image_uris'] == null
          ? null
          : ImageUris.fromJson(json['image_uris'] as Map<String, dynamic>)
      ..manaCost = json['mana_cost'] as String?
      ..cmc = (json['cmc'] as num?)?.toDouble()
      ..typeLine = json['type_line'] as String?
      ..oracleText = json['oracle_text'] as String?
      ..power = json['power'] as String?
      ..toughness = json['toughness'] as String?
      ..colors =
          (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..colorIdentity = (json['color_identity'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..keywords =
          (json['keywords'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..allParts = (json['all_parts'] as List<dynamic>?)
          ?.map((e) => AllParts.fromJson(e as Map<String, dynamic>))
          .toList()
      ..legalities = json['legalities'] == null
          ? null
          : Legalities.fromJson(json['legalities'] as Map<String, dynamic>)
      ..games =
          (json['games'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..reserved = json['reserved'] as bool?
      ..foil = json['foil'] as bool?
      ..nonfoil = json['nonfoil'] as bool?
      ..finishes =
          (json['finishes'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..oversized = json['oversized'] as bool?
      ..promo = json['promo'] as bool?
      ..reprint = json['reprint'] as bool?
      ..variation = json['variation'] as bool?
      ..setId = json['set_id'] as String?
      ..set = json['set'] as String?
      ..setName = json['set_name'] as String?
      ..setType = json['set_type'] as String?
      ..setUri = json['set_uri'] as String?
      ..setSearchUri = json['set_search_uri'] as String?
      ..scryfallSetUri = json['scryfall_set_uri'] as String?
      ..rulingsUri = json['rulings_uri'] as String?
      ..printsSearchUri = json['prints_search_uri'] as String?
      ..collectorNumber = json['collector_number'] as String?
      ..digital = json['digital'] as bool?
      ..rarity = json['rarity'] as String?
      ..cardBackId = json['card_back_id'] as String?
      ..artist = json['artist'] as String?
      ..artistIds = (json['artist_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..illustrationId = json['illustration_id'] as String?
      ..borderColor = json['border_color'] as String?
      ..frame = json['frame'] as String?
      ..securityStamp = json['security_stamp'] as String?
      ..fullArt = json['full_art'] as bool?
      ..textless = json['textless'] as bool?
      ..booster = json['booster'] as bool?
      ..storySpotlight = json['story_spotlight'] as bool?
      ..promoTypes = (json['promo_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..prices = json['prices'] == null
          ? null
          : Prices.fromJson(json['prices'] as Map<String, dynamic>)
      ..relatedUris = json['related_uris'] == null
          ? null
          : RelatedUris.fromJson(json['related_uris'] as Map<String, dynamic>)
      ..cardFaces = (json['card_faces'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : CardFace.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DeckCardToJson(DeckCard instance) => <String, dynamic>{
      'object': instance.object,
      'id': instance.id,
      'oracle_id': instance.oracleId,
      'multiverse_ids': instance.multiverseIds,
      'arena_id': instance.arenaId,
      'name': instance.name,
      'lang': instance.lang,
      'released_at': instance.releasedAt,
      'uri': instance.uri,
      'scryfall_uri': instance.scryfallUri,
      'layout': instance.layout,
      'highres_image': instance.highresImage,
      'image_status': instance.imageStatus,
      'image_uris': instance.imageUris,
      'mana_cost': instance.manaCost,
      'cmc': instance.cmc,
      'type_line': instance.typeLine,
      'oracle_text': instance.oracleText,
      'power': instance.power,
      'toughness': instance.toughness,
      'colors': instance.colors,
      'color_identity': instance.colorIdentity,
      'keywords': instance.keywords,
      'all_parts': instance.allParts,
      'legalities': instance.legalities,
      'games': instance.games,
      'reserved': instance.reserved,
      'foil': instance.foil,
      'nonfoil': instance.nonfoil,
      'finishes': instance.finishes,
      'oversized': instance.oversized,
      'promo': instance.promo,
      'reprint': instance.reprint,
      'variation': instance.variation,
      'set_id': instance.setId,
      'set': instance.set,
      'set_name': instance.setName,
      'set_type': instance.setType,
      'set_uri': instance.setUri,
      'set_search_uri': instance.setSearchUri,
      'scryfall_set_uri': instance.scryfallSetUri,
      'rulings_uri': instance.rulingsUri,
      'prints_search_uri': instance.printsSearchUri,
      'collector_number': instance.collectorNumber,
      'digital': instance.digital,
      'rarity': instance.rarity,
      'card_back_id': instance.cardBackId,
      'artist': instance.artist,
      'artist_ids': instance.artistIds,
      'illustration_id': instance.illustrationId,
      'border_color': instance.borderColor,
      'frame': instance.frame,
      'security_stamp': instance.securityStamp,
      'full_art': instance.fullArt,
      'textless': instance.textless,
      'booster': instance.booster,
      'story_spotlight': instance.storySpotlight,
      'promo_types': instance.promoTypes,
      'prices': instance.prices,
      'related_uris': instance.relatedUris,
      'card_faces': instance.cardFaces,
      'count': instance.count,
    };
