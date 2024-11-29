import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

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
  friend,
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
class CurrentUser extends User {
  @JsonKey(defaultValue: [])
  final List<Relation>? relations;
  CurrentUser(
      {required String id,
      required String username,
      required String discriminator,
      required bool online,
      required this.relations})
      : super(
            id: id,
            username: username,
            discriminator: discriminator,
            online: online);
  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}
