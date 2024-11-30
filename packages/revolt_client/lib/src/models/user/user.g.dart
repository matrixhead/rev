// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

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
