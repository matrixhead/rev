import 'dart:collection';
import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:revolt_client/src/models/message/message.dart';
import 'package:revolt_client/src/models/user/user.dart';
import 'package:rxdart/rxdart.dart';

class ChannelRepository {
  final Map<String, RevChannel> _channels = {};
  final Map<String, String> _dmchannelUserMappings = {};

  RevChannel addOrUpdateChannel(Channel channel, CurrentUser currentUser) {
    if (_channels[channel.id] case RevChannel enrichedChannel) {
      enrichedChannel._updateChannel(channel, currentUser);
      return enrichedChannel;
    }
    final enrichedChannel =
        RevChannel._fromChannel(channel: channel, currentUser: currentUser);
    if (channel.channelType == ChannelType.directMessage) {
      _dmchannelUserMappings[enrichedChannel.otherIds[0]] = channel.id;
    }
    _channels[channel.id] = enrichedChannel;
    return enrichedChannel;
  }

  RevChannel? getDmChannelForUser(String userid) {
    final channelId = _dmchannelUserMappings[userid];
    return _channels[channelId];
  }

  RevChannel? getChannelforId(String channelId) {
    return _channels[channelId];
  }
}

class RevChannel {
  Channel channel;
  final BehaviorSubject<LinkedHashMap<String, Message>> messages =
      BehaviorSubject.seeded(LinkedHashMap());

  RevChannel._internal({required this.channel});

  factory RevChannel._fromChannel(
      {required Channel channel, required CurrentUser currentUser}) {
    return RevChannel._internal(
        channel:
            _removeCurrentUser(channel: channel, currentUser: currentUser));
  }

  _updateChannel(Channel channel, CurrentUser currentUser) {
    this.channel =
        _removeCurrentUser(channel: channel, currentUser: currentUser);
  }

  static Channel _removeCurrentUser(
      {required Channel channel, required CurrentUser currentUser}) {
    final recipientsWOcurrentUser = channel.recipients;
    recipientsWOcurrentUser.remove(currentUser.id);
    return channel.copyWith(recipients: recipientsWOcurrentUser);
  }

  String get id => channel.id;

  List<String> get otherIds => channel.recipients;

  ChannelType get channelType => channel.channelType;
}

