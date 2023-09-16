import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:playground/network/responsemodels/basecard.dart';
import 'package:playground/network/responsemodels/card.dart';
import 'package:playground/utils/constants.dart';
import 'package:playground/utils/utils.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  List<ScryfallCard>? data;
  String? object;
  @JsonKey(name: 'total_cards')
  int? totalCards;
  @JsonKey(name: 'next_page')
  String? nextPageLink;

  SearchResponse({this.data, this.object, this.totalCards, this.nextPageLink});

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);

  @override
  String toString() {
    return data?.join('\n\n') ?? 'null';
  }
}

@JsonSerializable()
class ScryfallCard extends Equatable implements BaseCard {
  String? object;
  String? id;
  @JsonKey(name: 'oracle_id')
  String? oracleId;
  @JsonKey(name: 'multiverse_ids')
  List<int>? multiverseIds;
  @JsonKey(name: 'arena_id')
  int? arenaId;
  String? name;
  String? lang;
  @JsonKey(name: 'released_at')
  String? releasedAt;
  String? uri;
  @JsonKey(name: 'scryfall_uri')
  String? scryfallUri;
  String? layout;
  @JsonKey(name: 'highres_image')
  bool? highresImage;
  @JsonKey(name: 'image_status')
  String? imageStatus;
  @JsonKey(name: 'image_uris')
  ImageUris? imageUris;
  @JsonKey(name: 'mana_cost')
  String? manaCost;
  double? cmc;
  @JsonKey(name: 'type_line')
  String? typeLine;
  @JsonKey(name: 'oracle_text')
  String? oracleText;
  String? power;
  String? toughness;
  List<String>? colors;
  @JsonKey(name: 'color_identity')
  List<String>? colorIdentity;
  List<String>? keywords;
  @JsonKey(name: 'all_parts')
  List<AllParts>? allParts;
  Legalities? legalities;
  List<String>? games;
  bool? reserved;
  bool? foil;
  bool? nonfoil;
  List<String>? finishes;
  bool? oversized;
  bool? promo;
  bool? reprint;
  bool? variation;
  @JsonKey(name: 'set_id')
  String? setId;
  String? set;
  @JsonKey(name: 'set_name')
  String? setName;
  @JsonKey(name: 'set_type')
  String? setType;
  @JsonKey(name: 'set_uri')
  String? setUri;
  @JsonKey(name: 'set_search_uri')
  String? setSearchUri;
  @JsonKey(name: 'scryfall_set_uri')
  String? scryfallSetUri;
  @JsonKey(name: 'rulings_uri')
  String? rulingsUri;
  @JsonKey(name: 'prints_search_uri')
  String? printsSearchUri;
  @JsonKey(name: 'collector_number')
  String? collectorNumber;
  bool? digital;
  String? rarity;
  @JsonKey(name: 'card_back_id')
  String? cardBackId;
  String? artist;
  @JsonKey(name: 'artist_ids')
  List<String>? artistIds;
  @JsonKey(name: 'illustration_id')
  String? illustrationId;
  @JsonKey(name: 'border_color')
  String? borderColor;
  String? frame;
  @JsonKey(name: 'security_stamp')
  String? securityStamp;
  @JsonKey(name: 'full_art')
  bool? fullArt;
  bool? textless;
  bool? booster;
  @JsonKey(name: 'story_spotlight')
  bool? storySpotlight;
  @JsonKey(name: 'promo_types')
  List<String>? promoTypes;
  Prices? prices;
  @JsonKey(name: 'related_uris')
  RelatedUris? relatedUris;
  @JsonKey(name: 'card_faces')
  List<CardFace?>? cardFaces;

  ScryfallCard(
      {this.object,
      this.id,
      this.oracleId,
      this.multiverseIds,
      this.arenaId,
      this.name,
      this.lang,
      this.releasedAt,
      this.uri,
      this.scryfallUri,
      this.layout,
      this.highresImage,
      this.imageStatus,
      this.imageUris,
      this.manaCost,
      this.cmc,
      this.typeLine,
      this.oracleText,
      this.power,
      this.toughness,
      this.colors,
      this.colorIdentity,
      this.keywords,
      this.allParts,
      this.legalities,
      this.games,
      this.reserved,
      this.foil,
      this.nonfoil,
      this.finishes,
      this.oversized,
      this.promo,
      this.reprint,
      this.variation,
      this.setId,
      this.set,
      this.setName,
      this.setType,
      this.setUri,
      this.setSearchUri,
      this.scryfallSetUri,
      this.rulingsUri,
      this.printsSearchUri,
      this.collectorNumber,
      this.digital,
      this.rarity,
      this.cardBackId,
      this.artist,
      this.artistIds,
      this.illustrationId,
      this.borderColor,
      this.frame,
      this.securityStamp,
      this.fullArt,
      this.textless,
      this.booster,
      this.storySpotlight,
      this.promoTypes,
      this.prices,
      this.relatedUris,
      this.cardFaces});

  factory ScryfallCard.fromJson(Map<String, dynamic> json) =>
      _$ScryfallCardFromJson(json);

  Map<String, dynamic> toJson() => _$ScryfallCardToJson(this);

  @override
  String toString() {
    return '$name with id: ${getId()}   '
        'Mana cost: $manaCost   '
        'Colors: $colors    '
        'Artwork: ${imageUris?.artCrop}    '
        'Color identity: $colorIdentity';
  }

  @override
  List<Object?> get props => [id, name];

  @override
  String? getId() {
    return id;
  }

  @override
  String? getImageUrl({bool? firstFace}) {
    String? imageUrl;
    if (cardFaces?.first?.imageUris?.normal != null) {
      if (firstFace == false) {
        imageUrl = cardFaces?[1]?.imageUris?.normal;
      } else {
        imageUrl = cardFaces?.first?.imageUris?.normal;
      }
    } else {
      imageUrl = imageUris?.normal;
    }
    return imageUrl;
  }

  @override
  String? getName() {
    return name;
  }

  @override
  String? getManaCost() {
    String? manaCost;
    if (cardFaces?.first?.manaCost != null) {
      manaCost = cardFaces?.first?.manaCost;
    } else {
      manaCost = this.manaCost;
    }
    return manaCost;
  }

  @override
  String? getText() {
    return cardFaces != null ? cardFaces?.first?.oracleText : oracleText;
  }

  @override
  String? getType() {
    return StringUtils.buildLimitedString(
        string: cardFaces != null ? cardFaces?.first?.typeLine : typeLine,
        size: 10);
  }

  String? get cardType {
    final typeLine =
        cardFaces != null ? cardFaces?.first?.typeLine : this.typeLine;
    for (var type in BaseCardTypes.values) {
      if (typeLine?.contains(type.name) == true) {
        if (type == BaseCardTypes.Summon) {
          return BaseCardTypes.Creature.name;
        }
        return type.name;
      }
    }
    return null;
  }

  @override
  Map<String, String?> getPrices() {
    return {'usd': prices?.usd, 'eur': prices?.eur};
  }
}

@JsonSerializable()
class CardFace {
  String? object;
  String? name;
  @JsonKey(name: 'mana_cost')
  String? manaCost;
  @JsonKey(name: 'type_line')
  String? typeLine;
  @JsonKey(name: 'oracle_text')
  String? oracleText;
  List<String>? colors;
  String? power;
  String? toughness;
  String? artist;
  @JsonKey(name: 'artist_id')
  String? artistId;
  @JsonKey(name: 'illustration_id')
  String? illustrationId;
  @JsonKey(name: 'image_uris')
  ImageUris? imageUris;

  CardFace(
      {this.object,
      this.name,
      this.manaCost,
      this.typeLine,
      this.oracleText,
      this.colors,
      this.power,
      this.toughness,
      this.artist,
      this.artistId,
      this.illustrationId,
      this.imageUris});

  factory CardFace.fromJson(Map<String, dynamic> json) =>
      _$CardFaceFromJson(json);

  Map<String, dynamic> toJson() => _$CardFaceToJson(this);
}

class ImageUris {
  String? small;
  String? normal;
  String? large;
  String? png;
  String? artCrop;
  String? borderCrop;

  ImageUris(
      {this.small,
      this.normal,
      this.large,
      this.png,
      this.artCrop,
      this.borderCrop});

  ImageUris.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    normal = json['normal'];
    large = json['large'];
    png = json['png'];
    artCrop = json['art_crop'];
    borderCrop = json['border_crop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['small'] = small;
    data['normal'] = normal;
    data['large'] = large;
    data['png'] = png;
    data['art_crop'] = artCrop;
    data['border_crop'] = borderCrop;
    return data;
  }
}

class AllParts {
  String? object;
  String? id;
  String? component;
  String? name;
  String? typeLine;
  String? uri;

  AllParts(
      {this.object,
      this.id,
      this.component,
      this.name,
      this.typeLine,
      this.uri});

  AllParts.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    id = json['id'];
    component = json['component'];
    name = json['name'];
    typeLine = json['type_line'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    data['id'] = id;
    data['component'] = component;
    data['name'] = name;
    data['type_line'] = typeLine;
    data['uri'] = uri;
    return data;
  }
}

class Legalities {
  String? standard;
  String? future;
  String? historic;
  String? gladiator;
  String? pioneer;
  String? explorer;
  String? modern;
  String? legacy;
  String? pauper;
  String? vintage;
  String? penny;
  String? commander;
  String? oathbreaker;
  String? brawl;
  String? historicbrawl;
  String? alchemy;
  String? paupercommander;
  String? duel;
  String? oldschool;
  String? premodern;
  String? predh;

  Legalities(
      {this.standard,
      this.future,
      this.historic,
      this.gladiator,
      this.pioneer,
      this.explorer,
      this.modern,
      this.legacy,
      this.pauper,
      this.vintage,
      this.penny,
      this.commander,
      this.oathbreaker,
      this.brawl,
      this.historicbrawl,
      this.alchemy,
      this.paupercommander,
      this.duel,
      this.oldschool,
      this.premodern,
      this.predh});

  Legalities.fromJson(Map<String, dynamic> json) {
    standard = json['standard'];
    future = json['future'];
    historic = json['historic'];
    gladiator = json['gladiator'];
    pioneer = json['pioneer'];
    explorer = json['explorer'];
    modern = json['modern'];
    legacy = json['legacy'];
    pauper = json['pauper'];
    vintage = json['vintage'];
    penny = json['penny'];
    commander = json['commander'];
    oathbreaker = json['oathbreaker'];
    brawl = json['brawl'];
    historicbrawl = json['historicbrawl'];
    alchemy = json['alchemy'];
    paupercommander = json['paupercommander'];
    duel = json['duel'];
    oldschool = json['oldschool'];
    premodern = json['premodern'];
    predh = json['predh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['standard'] = standard;
    data['future'] = future;
    data['historic'] = historic;
    data['gladiator'] = gladiator;
    data['pioneer'] = pioneer;
    data['explorer'] = explorer;
    data['modern'] = modern;
    data['legacy'] = legacy;
    data['pauper'] = pauper;
    data['vintage'] = vintage;
    data['penny'] = penny;
    data['commander'] = commander;
    data['oathbreaker'] = oathbreaker;
    data['brawl'] = brawl;
    data['historicbrawl'] = historicbrawl;
    data['alchemy'] = alchemy;
    data['paupercommander'] = paupercommander;
    data['duel'] = duel;
    data['oldschool'] = oldschool;
    data['premodern'] = premodern;
    data['predh'] = predh;
    return data;
  }

  @override
  String toString() {
    final json = toJson();
    var toString = emptyString;
    json.forEach((key, value) {
      toString += '$key: ${value == 'legal' ? value : 'not legal'}\n';
    });
    return toString;
  }
}

class Prices {
  String? usd;
  String? usdFoil;
  String? usdEtched;
  String? eur;
  String? eurFoil;
  String? tix;

  Prices(
      {this.usd,
      this.usdFoil,
      this.usdEtched,
      this.eur,
      this.eurFoil,
      this.tix});

  Prices.fromJson(Map<String, dynamic> json) {
    usd = json['usd'];
    usdFoil = json['usd_foil'];
    usdEtched = json['usd_etched'];
    eur = json['eur'];
    eurFoil = json['eur_foil'];
    tix = json['tix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usd'] = usd;
    data['usd_foil'] = usdFoil;
    data['usd_etched'] = usdEtched;
    data['eur'] = eur;
    data['eur_foil'] = eurFoil;
    data['tix'] = tix;
    return data;
  }
}

class RelatedUris {
  String? tcgplayerInfiniteArticles;
  String? tcgplayerInfiniteDecks;
  String? edhrec;

  RelatedUris(
      {this.tcgplayerInfiniteArticles,
      this.tcgplayerInfiniteDecks,
      this.edhrec});

  RelatedUris.fromJson(Map<String, dynamic> json) {
    tcgplayerInfiniteArticles = json['tcgplayer_infinite_articles'];
    tcgplayerInfiniteDecks = json['tcgplayer_infinite_decks'];
    edhrec = json['edhrec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tcgplayer_infinite_articles'] = tcgplayerInfiniteArticles;
    data['tcgplayer_infinite_decks'] = tcgplayerInfiniteDecks;
    data['edhrec'] = edhrec;
    return data;
  }
}
