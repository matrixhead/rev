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
  RelationStatus.friend: 'friend',
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
