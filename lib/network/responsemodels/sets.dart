import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sets.g.dart';

@JsonSerializable()
class SetsResponse {
  List<Set>? sets;

  SetsResponse({this.sets});

  factory SetsResponse.fromJson(Map<String, dynamic> json) =>
      _$SetsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SetsResponseToJson(this);

  @override
  String toString() {
    return sets?.join('\n\n') ?? 'null';
  }
}

@JsonSerializable()
class Set extends Equatable {
  String? code;
  String? name;
  String? type;
  List<dynamic>? booster;
  String? releaseDate;
  String? block;
  bool? onlineOnly;

  Set({
    this.code,
    this.name,
    this.type,
    this.booster,
    this.releaseDate,
    this.block,
    this.onlineOnly,
  });

  factory Set.fromJson(Map<String, dynamic> json) => _$SetFromJson(json);

  Map<String, dynamic> toJson() => _$SetToJson(this);

  DateTime? get releaseDateAsDateTime {
    if (releaseDate != null) {
      return DateTime.parse(releaseDate!);
    } else {
      return null;
    }
  }

  @override
  String toString() {
    return 'code: $code\nname: $name\ntype: $type\nbooster: $booster\nreleaseDate:$releaseDate\nblock: $block\nonlineOnly: $onlineOnly';
  }

  @override
  List<Object?> get props => [code, name];
}
