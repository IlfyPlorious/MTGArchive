import 'package:json_annotation/json_annotation.dart';

part 'autocomplete.g.dart';

@JsonSerializable()
class AutocompleteResponse {
  AutocompleteResponse({this.object, this.totalValues, this.data});

  final String? object;
  @JsonKey(name: 'total_values')
  final int? totalValues;
  final List<String?>? data;

  factory AutocompleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AutocompleteResponseToJson(this);
}
