// To parse this JSON data, do
//
//     final channel = channelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:revolt_client/src/models/message/message.dart';
import 'package:rxdart/rxdart.dart';

part 'channel.g.dart';

@JsonSerializable()
class Channel {
  @JsonKey(name: "channel_type")
  String channelType;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "active")
  bool active;
  @JsonKey(name: "recipients")
  List<String> recipients;
  @JsonKey(name: "last_message_id")
  String? lastMessageId;

  Channel({
    required this.channelType,
    required this.id,
    required this.active,
    required this.recipients,
    required this.lastMessageId,
  });

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelToJson(this);
}

class EnrichedChannel {
  final Channel channel;
  final BehaviorSubject<Map<String, Message>> messages = BehaviorSubject.seeded({});
  EnrichedChannel({
    required this.channel,
  });
}
