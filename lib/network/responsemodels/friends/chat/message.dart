import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class FirebaseMessage extends Equatable {
  const FirebaseMessage({this.idFrom, this.idTo, this.timestamp, this.content});

  @JsonKey(name: 'id_from')
  final String? idFrom;
  @JsonKey(name: 'id_to')
  final String? idTo;
  final String? content;
  final String? timestamp;

  factory FirebaseMessage.fromJson(Map<String, dynamic> json) =>
      _$FirebaseMessageFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseMessageToJson(this);

  @override
  List<Object?> get props => [idFrom, idTo, content, timestamp];
}
