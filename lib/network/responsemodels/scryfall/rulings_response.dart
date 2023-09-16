import 'package:json_annotation/json_annotation.dart';

part 'rulings_response.g.dart';

@JsonSerializable()
class ScryfallRulingResponse {
  ScryfallRulingResponse({
    this.object,
    this.hasMore,
    this.data,
  });

  String? object;
  @JsonKey(name: 'has_more')
  bool? hasMore;
  List<Rulings>? data;

  factory ScryfallRulingResponse.fromJson(Map<String, dynamic> json) =>
      _$ScryfallRulingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScryfallRulingResponseToJson(this);
}

@JsonSerializable()
class Rulings {
  Rulings({
    this.object,
    this.oracleId,
    this.source,
    this.publishedAt,
    this.comment,
  });

  String? object;
  @JsonKey(name: 'oracle_id')
  String? oracleId;
  String? source;
  @JsonKey(name: 'published_at')
  String? publishedAt;
  String? comment;

  factory Rulings.fromJson(Map<String, dynamic> json) =>
      _$RulingsFromJson(json);

  Map<String, dynamic> toJson() => _$RulingsToJson(this);
}
