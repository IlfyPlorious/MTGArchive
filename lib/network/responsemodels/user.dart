import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:playground/network/responsemodels/basecard.dart';
import 'package:playground/utils/utils.dart';

part 'user.g.dart';

@JsonSerializable()
class FirebaseUser extends Equatable {
  FirebaseUser({this.email, this.name, this.imageUrl, this.id});

  final String? email;
  final String? name;
  final String? imageUrl;
  final String? id;

  factory FirebaseUser.fromJson(Map<String, dynamic> json) =>
      _$FirebaseUserFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseUserToJson(this);

  @override
  List<Object?> get props => [email, name, imageUrl, id];
}
