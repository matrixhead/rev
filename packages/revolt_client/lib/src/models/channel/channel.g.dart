// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Channel _$ChannelFromJson(Map<String, dynamic> json) => Channel(
      channelType: json['channel_type'] as String,
      id: json['_id'] as String,
      active: json['active'] as bool,
      recipients: (json['recipients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastMessageId: json['last_message_id'] as String?,
    );

Map<String, dynamic> _$ChannelToJson(Channel instance) => <String, dynamic>{
      'channel_type': instance.channelType,
      '_id': instance.id,
      'active': instance.active,
      'recipients': instance.recipients,
      'last_message_id': instance.lastMessageId,
    };
