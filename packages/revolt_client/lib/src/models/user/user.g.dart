// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RelationUserCWProxy {
  RelationUser discriminator(String discriminator);

  RelationUser id(String id);

  RelationUser online(bool online);

  RelationUser relationStatus(RelationStatus relationStatus);

  RelationUser username(String username);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RelationUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RelationUser(...).copyWith(id: 12, name: "My name")
  /// ````
  RelationUser call({
    String? discriminator,
    String? id,
    bool? online,
    RelationStatus? relationStatus,
    String? username,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRelationUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRelationUser.copyWith.fieldName(...)`
class _$RelationUserCWProxyImpl implements _$RelationUserCWProxy {
  final RelationUser _value;

  const _$RelationUserCWProxyImpl(this._value);

  @override
  RelationUser discriminator(String discriminator) =>
      this(discriminator: discriminator);

  @override
  RelationUser id(String id) => this(id: id);

  @override
  RelationUser online(bool online) => this(online: online);

  @override
  RelationUser relationStatus(RelationStatus relationStatus) =>
      this(relationStatus: relationStatus);

  @override
  RelationUser username(String username) => this(username: username);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RelationUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RelationUser(...).copyWith(id: 12, name: "My name")
  /// ````
  RelationUser call({
    Object? discriminator = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? online = const $CopyWithPlaceholder(),
    Object? relationStatus = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
  }) {
    return RelationUser(
      discriminator:
          discriminator == const $CopyWithPlaceholder() || discriminator == null
              ? _value.discriminator
              // ignore: cast_nullable_to_non_nullable
              : discriminator as String,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      online: online == const $CopyWithPlaceholder() || online == null
          ? _value.online
          // ignore: cast_nullable_to_non_nullable
          : online as bool,
      relationStatus: relationStatus == const $CopyWithPlaceholder() ||
              relationStatus == null
          ? _value.relationStatus
          // ignore: cast_nullable_to_non_nullable
          : relationStatus as RelationStatus,
      username: username == const $CopyWithPlaceholder() || username == null
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
    );
  }
}

extension $RelationUserCopyWith on RelationUser {
  /// Returns a callable class that can be used as follows: `instanceOfRelationUser.copyWith(...)` or like so:`instanceOfRelationUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RelationUserCWProxy get copyWith => _$RelationUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Relation _$RelationFromJson(Map<String, dynamic> json) => Relation(
      id: json['_id'] as String,
      relationStatus: $enumDecode(_$RelationStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$RelationToJson(Relation instance) => <String, dynamic>{
      '_id': instance.id,
      'status': _$RelationStatusEnumMap[instance.relationStatus]!,
    };

const _$RelationStatusEnumMap = {
  RelationStatus.friend: 'Friend',
  RelationStatus.outgoing: 'Outgoing',
  RelationStatus.incoming: 'Incoming',
};

RelationUser _$RelationUserFromJson(Map<String, dynamic> json) => RelationUser(
      id: json['_id'] as String,
      username: json['username'] as String,
      discriminator: json['discriminator'] as String,
      online: json['online'] as bool,
      relationStatus:
          $enumDecode(_$RelationStatusEnumMap, json['relationship']),
    );

Map<String, dynamic> _$RelationUserToJson(RelationUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'discriminator': instance.discriminator,
      'online': instance.online,
      'relationship': _$RelationStatusEnumMap[instance.relationStatus]!,
    };

CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) => CurrentUser(
      id: json['_id'] as String,
      username: json['username'] as String,
      discriminator: json['discriminator'] as String,
      online: json['online'] as bool,
      relations: (json['relations'] as List<dynamic>?)
              ?.map((e) => Relation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CurrentUserToJson(CurrentUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'discriminator': instance.discriminator,
      'online': instance.online,
      'relations': instance.relations,
    };
