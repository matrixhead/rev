// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticateEvent _$AuthenticateEventFromJson(Map<String, dynamic> json) =>
    AuthenticateEvent(
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthenticateEventToJson(AuthenticateEvent instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

AuthenticatedEvent _$AuthenticatedEventFromJson(Map<String, dynamic> json) =>
    AuthenticatedEvent();

Map<String, dynamic> _$AuthenticatedEventToJson(AuthenticatedEvent instance) =>
    <String, dynamic>{};

MessageEvent _$MessageEventFromJson(Map<String, dynamic> json) => MessageEvent(
      Message.fromJson(MessageEvent._passDownToParseMessage(json, 'message')
          as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageEventToJson(MessageEvent instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

UnknownEvent _$UnknownEventFromJson(Map<String, dynamic> json) => UnknownEvent(
      type: json['type'] as String,
    );

Map<String, dynamic> _$UnknownEventToJson(UnknownEvent instance) =>
    <String, dynamic>{
      'type': instance.type,
    };
