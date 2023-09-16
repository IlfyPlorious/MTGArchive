import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friendship.g.dart';

@JsonSerializable()
class FirebaseFriendship extends Equatable {
  const FirebaseFriendship(
      {this.idUser1, this.idUser2, this.id, this.startDate});

  @JsonKey(name: 'id_user_1')
  final String? idUser1;
  @JsonKey(name: 'id_user_2')
  final String? idUser2;
  final String? id;
  @JsonKey(name: 'start_date')
  final String? startDate;

  factory FirebaseFriendship.fromJson(Map<String, dynamic> json) =>
      _$FirebaseFriendshipFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseFriendshipToJson(this);

  @override
  List<Object?> get props => [id, idUser1, idUser2, startDate];
}
