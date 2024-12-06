import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:revolt_client/src/models/message/message.dart';
import 'package:revolt_client/src/models/user/user.dart';
part "ws_events.g.dart";

abstract class WsEvents {
  WsEvents();
}

abstract class ServerToClientEvents extends WsEvents {
  ServerToClientEvents();
  factory ServerToClientEvents.fromJson(Map<String, dynamic> json) {
    switch (json["type"]) {
      case AuthenticatedEvent.type:
        return AuthenticatedEvent.fromJson(json);
      case MessageEvent.type:
        return MessageEvent.fromJson(json);
      case ReadyEvent.type:
        return ReadyEvent.fromJson(json);
      default:
        return UnknownEvent.fromJson(json);
    }
  }
}

abstract class ClientToServerEvents extends WsEvents {
  ClientToServerEvents();
  Map<String, dynamic> _addtypetoJson(Map<String, dynamic> json, String type) {
    json["type"] = type;
    return json;
  }
}

@JsonSerializable()
class AuthenticateEvent extends ClientToServerEvents {
  @JsonKey(includeToJson: false, includeFromJson: false)
  static final type = "Authenticate";
  final String token;
  AuthenticateEvent({required this.token});

  // Add the fromJson factory method
  factory AuthenticateEvent.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateEventFromJson(json);

  // Add the toJson method
  Map<String, dynamic> toJson() =>
      _addtypetoJson(_$AuthenticateEventToJson(this), type);
}

/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

@JsonSerializable()
class AuthenticatedEvent extends ServerToClientEvents {
  @JsonKey(includeToJson: false, includeFromJson: false)
  static const type = "Authenticated";
  AuthenticatedEvent();

  // Factory constructor for creating a new instance from a map
  factory AuthenticatedEvent.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedEventFromJson(json);

  // Method for converting an instance to a map
  Map<String, dynamic> toJson() => _$AuthenticatedEventToJson(this);
}

@JsonSerializable()
class MessageEvent extends ServerToClientEvents {
  @JsonKey(includeToJson: false, includeFromJson: false)
  static const type = "Message";
  @JsonKey(readValue: _passDownToParseMessage)
  final Message message;
  MessageEvent(this.message);

  // Factory constructor for creating a new instance from a map
  factory MessageEvent.fromJson(Map<String, dynamic> json) =>
      _$MessageEventFromJson(json);

  // Method for converting an instance to a map
  Map<String, dynamic> toJson() => _$MessageEventToJson(this);

  static _passDownToParseMessage(Map map, String str) {
    return map;
  }
}

@JsonSerializable()
class ReadyEvent extends ServerToClientEvents {
  @JsonKey(includeToJson: false, includeFromJson: false)
  static const type = "Ready";

  final List<User> users;
  final List<Channel> channels;

  ReadyEvent(this.users, this.channels);

  factory ReadyEvent.fromJson(Map<String, dynamic> json) {
    return  _$ReadyEventFromJson(json);
    }

  Map<String, dynamic> toJson() => _$ReadyEventToJson(this);
}

@JsonSerializable()
class UnknownEvent extends ServerToClientEvents {
  final String type;
  UnknownEvent({required this.type});

  factory UnknownEvent.fromJson(Map<String, dynamic> json) =>
      _$UnknownEventFromJson(json);

  // Add the toJson method
  Map<String, dynamic> toJson() => _$UnknownEventToJson(this);
}
