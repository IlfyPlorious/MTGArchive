import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'formats.g.dart';
@JsonSerializable()
class FormatsResponse {
  List<String?>? formats;

  FormatsResponse({this.formats});

  factory FormatsResponse.fromJson(Map<String, dynamic> json) =>
      _$FormatsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FormatsResponseToJson(this);

  @override
  String toString() {
    return formats?.join('\n\n') ?? 'null';
  }
}
