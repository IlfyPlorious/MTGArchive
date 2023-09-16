import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:playground/models/deck_constraint.dart';

part 'deck.g.dart';

@JsonSerializable()
class Deck extends Equatable {
  Deck({this.id, this.name, this.format, this.colors, this.deckConstraints});

  String? id;
  String? name;
  String? format;
  List<String?>? colors;
  @JsonKey(name: "background_url")
  List<String?>? backgroundUrl;
  DeckConstraints? deckConstraints;

  factory Deck.fromJson(Map<String, dynamic> json) => _$DeckFromJson(json);

  Map<String, dynamic> toJson() => _$DeckToJson(this);

  @override
  List<Object?> get props =>
      [name, format, colors, backgroundUrl, deckConstraints];

  DeckConstraints getDeckConstraints() {
    switch (format) {
      case 'standard':
        return StandardConstraints();
      case 'future':
        return StandardConstraints();
      case 'historic':
        return HistoricConstraints();
      case 'gladiator':
        return StandardConstraints();
      case 'pioneer':
        return PioneerConstraints();
      case 'explorer':
        return StandardConstraints();
      case 'modern':
        return StandardConstraints();
      case 'legacy':
        return StandardConstraints();
      case 'pauper':
        return PauperConstraints();
      case 'vintage':
        return VintageConstraints();
      case 'commander':
        return CommanderConstraints();
      case 'paupercommander':
        return CommanderConstraints();
      case 'predh':
        return CommanderConstraints();
      default:
        return StandardConstraints();
    }
  }
}

enum Formats {
  standard,
  future,
  historic,
  gladiator,
  pioneer,
  explorer,
  modern,
  legacy,
  pauper,
  vintage,
  penny,
  commander,
  oathbreaker,
  brawl,
  historicbrawl,
  alchemy,
  paupercommander,
  duel,
  oldschool,
  premodern,
  predh
}
