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

/// A class representing a channel in the Revolt client.
class RevChannel {
  RevChannel._internal({required Channel channel}) : _channel = channel;

  factory RevChannel._fromChannel({
    required Channel channel,
    required CurrentUser currentUser,
  }) {
    return RevChannel._internal(
      channel: _removeCurrentUser(channel: channel, currentUser: currentUser),
    );
  }
  Channel _channel;

  /// A BehaviorSubject that holds a seeded LinkedHashMap of messages.
  final BehaviorSubject<LinkedHashMap<String, Message>> messages =
      BehaviorSubject.seeded(LinkedHashMap());

  void _updateChannel(Channel channel, CurrentUser currentUser) {
    _channel = _removeCurrentUser(channel: channel, currentUser: currentUser);
  }

  static Channel _removeCurrentUser({
    required Channel channel,
    required CurrentUser currentUser,
  }) {
    final recipientsWOcurrentUser = channel.recipients..remove(currentUser.id);
    return channel.copyWith(recipients: recipientsWOcurrentUser);
  }

  /// Returns the unique identifier of the channel.
  String get id => _channel.id;

  /// Returns a list of recipient IDs associated with the channel.
  List<String> get otherIds => _channel.recipients;

  /// Returns the type of the channel.
  ChannelType get channelType => _channel.channelType;
}
