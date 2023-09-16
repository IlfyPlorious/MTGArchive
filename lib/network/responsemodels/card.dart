import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:playground/network/responsemodels/basecard.dart';
import 'package:playground/utils/utils.dart';

part 'card.g.dart';

@JsonSerializable()
class SingleCardResponse {
  Card? card;

  SingleCardResponse({this.card});

  factory SingleCardResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleCardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleCardResponseToJson(this);
}

@JsonSerializable()
class CardsResponse {
  List<Card>? cards;

  CardsResponse({this.cards});

  factory CardsResponse.fromJson(Map<String, dynamic> json) =>
      _$CardsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CardsResponseToJson(this);

  @override
  String toString() {
    return cards?.join('\n\n') ?? 'null';
  }
}

@JsonSerializable()
class Card extends Equatable implements BaseCard {
  String? name;
  List<String>? names;
  String? manaCost;
  double? cmc;
  List<String>? colors;
  List<String>? colorIdentity;
  String? type;
  List<String>? supertypes;
  List<String>? types;
  List<String>? subtypes;
  String? rarity;
  String? set;
  String? text;
  String? artist;
  String? number;
  String? power;
  String? toughness;
  String? layout;
  String? multiverseid;
  String? imageUrl;
  List<Rulings>? rulings;
  List<ForeignNames>? foreignNames;
  List<String>? printings;
  String? originalText;
  String? originalType;
  List<Legality>? legalities;
  String? id;

  Card(
      {this.name,
      this.names,
      this.manaCost,
      this.cmc,
      this.colors,
      this.colorIdentity,
      this.type,
      this.supertypes,
      this.types,
      this.subtypes,
      this.rarity,
      this.set,
      this.text,
      this.artist,
      this.number,
      this.power,
      this.toughness,
      this.layout,
      this.multiverseid,
      this.imageUrl,
      this.rulings,
      this.foreignNames,
      this.printings,
      this.originalText,
      this.originalType,
      this.legalities,
      this.id});

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);

  @override
  String toString() {
    return '$name with id: $id\nMana cost: $manaCost\nColors: $colors';
  }

  @override
  List<Object?> get props => [id, name];

  @override
  String? getId() {
    return multiverseid;
  }

  @override
  String? getImageUrl({bool? firstFace}) {
    return imageUrl;
  }

  @override
  String? getName() {
    return name;
  }

  @override
  String? getManaCost() {
    return manaCost?.replaceAll('{', '').replaceAll('}', '');
  }

  @override
  String? getText() {
    return StringUtils.buildLimitedString(string: text, size: 50);
  }

  @override
  String? getType() {
    return StringUtils.buildLimitedString(string: type, size: 10);
  }

  @override
  Map<String, String?> getPrices() {
    return {'usd': null, 'eur': null};
  }
}

@JsonSerializable()
class Legality extends Equatable {
  String? format;
  String? legality;

  Legality({this.format, this.legality});

  factory Legality.fromJson(Map<String, dynamic> json) =>
      _$LegalityFromJson(json);

  Map<String, dynamic> toJson() => _$LegalityToJson(this);

  @override
  String toString() {
    return '$format: $legality';
  }

  @override
  List<Object?> get props => [format, legality];
}

@JsonSerializable()
class Rulings {
  String? date;
  String? text;

  Rulings({this.date, this.text});

  factory Rulings.fromJson(Map<String, dynamic> json) =>
      _$RulingsFromJson(json);

  Map<String, dynamic> toJson() => _$RulingsToJson(this);

  @override
  String toString() => '$date: $text';
}

@JsonSerializable()
class ForeignNames {
  String? name;
  String? language;
  int? multiverseid;

  ForeignNames({this.name, this.language, this.multiverseid});

  factory ForeignNames.fromJson(Map<String, dynamic> json) =>
      _$ForeignNamesFromJson(json);

  Map<String, dynamic> toJson() => _$ForeignNamesToJson(this);
}

enum Layouts {
  any,
  normal,
  split,
  flip,
  doubleFaced,
  token,
  plane,
  scheme,
  phenomenon,
  leveler,
  vanguard,
  aftermath
}

extension LayoutsX on Layouts {
  String? get apiName {
    switch (this) {
      case Layouts.doubleFaced:
        return 'double-faced';
      case Layouts.any:
        return null;
      default:
        return name;
    }
  }
}

enum Colors { White, Blue, Black, Red, Green, Colorless }

enum ColorIdentities { W, U, B, R, G, C }

enum Rarities {
  Any,
  Common,
  Uncommon,
  Rare,
  MythicRare,
  Special,
  BasicLand,
  mythic
}

extension RaritiesX on Rarities {
  String? get nameApi {
    switch (this) {
      case Rarities.MythicRare:
        return 'Mythic Rare';
      case Rarities.BasicLand:
        return 'Basic Land';
      case Rarities.Any:
        return null;
      default:
        return name;
    }
  }
}

enum LegalityValues { Legal, Banned, Restricted }

enum CardTypes {
  Any,
  Artifact,
  Basic,
  Conspiracy,
  Creature,
  Dungeon,
  Eaturecray,
  Enchantment,
  Ever,
  Host,
  Instant,
  Land,
  Legendary,
  Ongoing,
  Phenomenon,
  Plane,
  Planeswalker,
  Scariest,
  Scheme,
  See,
  Snow,
  Sorcery,
  Summon,
  Tribal,
  Vanguard,
  World
}

enum BaseCardTypes {
  Artifact,
  Conspiracy,
  Creature,
  Dungeon,
  Eaturecray,
  Enchantment,
  Instant,
  Land,
  Planeswalker,
  Scheme,
  Sorcery,
  Summon,
}

extension CardTypesX on CardTypes {
  String? get nameValue {
    switch (this) {
      case CardTypes.Any:
        return null;
      default:
        return name;
    }
  }
}
