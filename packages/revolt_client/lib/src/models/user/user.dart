// ignore_for_file: use_super_parameters

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

@immutable
abstract class BaseUser {
  @JsonKey(name: "_id")
  final String id;

  BaseUser({required this.id});
}

abstract class User extends BaseUser {
  final String username;
  final String discriminator;
  final bool online;

  User({
    required id,
    required this.username,
    required this.discriminator,
    required this.online,
  }) : super(id: id);
}

@JsonEnum()
enum RelationStatus {
  @JsonValue("Friend")
  friend,
  @JsonValue("Outgoing")
  outgoing,
  @JsonValue("Incoming")
  incoming
}

@JsonSerializable()
class Relation extends BaseUser {
  @JsonKey(name: "status")
  final RelationStatus relationStatus;

  Relation({required String id, required this.relationStatus}) : super(id: id);

  factory Relation.fromJson(Map<String, dynamic> json) =>
      _$RelationFromJson(json);

  Map<String, dynamic> toJson() => _$RelationToJson(this);
}

@JsonSerializable()
@CopyWith()
class RelationUser extends User {
  //
  @JsonKey(name: "relationship")
  final RelationStatus relationStatus;

  RelationUser(
      {required String super.id,
      required super.username,
      required super.discriminator,
      required super.online,
      required this.relationStatus});

  factory RelationUser.fromJson(Map<String, dynamic> json) =>
      _$RelationUserFromJson(json);

  Map<String, dynamic> toJson() => _$RelationUserToJson(this);
}

@JsonSerializable()
@CopyWith()
class CurrentUser extends User {
  @JsonKey(defaultValue: [])
  final List<Relation>? relations;
  CurrentUser(
      {required String super.id,
      required super.username,
      required super.discriminator,
      required super.online,
      required this.relations});
  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}
