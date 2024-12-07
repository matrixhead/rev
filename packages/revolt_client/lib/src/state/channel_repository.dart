import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:revolt_client/src/models/message/message.dart';
import 'package:revolt_client/src/models/user/user.dart';
import 'package:rxdart/rxdart.dart';

class ChannelRepository {
  final Map<String, EnrichedChannel> _channels = {};
  final Map<String, String> _dmchannelUserMappings = {};

  EnrichedChannel addOrUpdateChannel(Channel channel, CurrentUser currentUser) {
    if (_channels[channel.id] case EnrichedChannel enrichedChannel) {
      enrichedChannel._updateChannel(channel, currentUser);
      return enrichedChannel;
    }
    final enrichedChannel =
        EnrichedChannel._fromChannel(channel: channel, currentUser: currentUser);
    if (channel.channelType == ChannelType.directMessage) {
      _dmchannelUserMappings[enrichedChannel.otherIds[0]] = channel.id;
    }
    _channels[channel.id] = enrichedChannel;
    return enrichedChannel;
  }

  EnrichedChannel? getDmChannelForUser(String userid) {
    final channelId = _dmchannelUserMappings[userid];
    return _channels[channelId];
  }
}

class EnrichedChannel {
  Channel channel;
  final BehaviorSubject<Map<String, Message>> messages =
      BehaviorSubject.seeded({});

  EnrichedChannel._internal({required this.channel});
  
  factory EnrichedChannel._fromChannel(
      {required Channel channel, required CurrentUser currentUser}) {
    return EnrichedChannel._internal(
        channel:
            _removerCurrentUser(channel: channel, currentUser: currentUser));
  }

  _updateChannel(Channel channel, CurrentUser currentUser) {
    this.channel =
        _removerCurrentUser(channel: channel, currentUser: currentUser);
  }

  static Channel _removerCurrentUser(
      {required Channel channel, required CurrentUser currentUser}) {
    final recipientsWOcurrentUser = channel.recipients;
    recipientsWOcurrentUser.remove(currentUser.id);
    return channel.copyWith(recipients: recipientsWOcurrentUser);
  }


  String get id => channel.id;

  List<String> get otherIds => channel.recipients;

  ChannelType get channelType => channel.channelType;
}
