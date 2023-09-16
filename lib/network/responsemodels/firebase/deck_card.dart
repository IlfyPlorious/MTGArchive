import 'package:json_annotation/json_annotation.dart';
import 'package:playground/network/responsemodels/search_response.dart';

part 'deck_card.g.dart';

@JsonSerializable()
class DeckCard extends ScryfallCard {
  DeckCard({this.count});

  int? count;

  factory DeckCard.fromJson(Map<String, dynamic> json) =>
      _$DeckCardFromJson(json);

  Map<String, dynamic> toJson() => _$DeckCardToJson(this);
}
