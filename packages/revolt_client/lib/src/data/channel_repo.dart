import 'dart:collection';

import 'package:revolt_client/revolt_client.dart';
import 'package:revolt_client/src/models/channel/channel.dart';
import 'package:revolt_client/src/state/rev_state.dart';
import 'package:rxdart/rxdart.dart';

class ChannelReposotory {
  ChannelReposotory({required this.state});

  final RevState state;

  RevChannel addOrUpdateChannel(Channel channel, CurrentUser currentUser) {
    if (state.channelRepoState.channels[channel.id]
        case final RevChannel enrichedChannel) {
      enrichedChannel._updateChannel(channel, currentUser);
      return enrichedChannel;
    }
    final enrichedChannel = RevChannel._fromChannel(
      channel: channel,
      currentUser: currentUser,
    );
    if (channel.channelType == ChannelType.directMessage) {
      state.channelRepoState.dmchannelUserMappings[enrichedChannel
              .otherIds[0]] =
          channel.id;
    }
    state.channelRepoState.channels[channel.id] = enrichedChannel;
    return enrichedChannel;
  }

  RevChannel? getDmChannelForUser(String userid) {
    final channelId = state.channelRepoState.dmchannelUserMappings[userid];
    return state.channelRepoState.channels[channelId];
  }

  RevChannel? getChannelforId(String channelId) {
    return state.channelRepoState.channels[channelId];
  }
}

class RevChannelState {
  RevChannelState({required Channel channel}) : _channel = channel;
  Channel _channel;

  final List<ClientRevMessage> _sentMessages = [];

  final LinkedHashMap<String, ServerRevMessage> _messages = LinkedHashMap();

  final BehaviorSubject<Iterable<RevMessage>> messages = BehaviorSubject.seeded(
    [],
  );
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

  final List<ClientRevMessage> _sentMessages = [];

  final LinkedHashMap<String, ServerRevMessage> _messages = LinkedHashMap();

  final BehaviorSubject<Iterable<RevMessage>> messages = BehaviorSubject.seeded(
    [],
  );

  void emitMessages() {
    final messageIter = _messages.values.cast<RevMessage>();
    final sentMessagesIter = _sentMessages.cast<RevMessage>();
    final iterable = messageIter.followedBy(sentMessagesIter);
    messages.add(iterable);
  }

  void addSendMessage(ClientRevMessage message) {
    _sentMessages.add(message);
    emitMessages();
  }

  void addMessages(List<Message> messages) {
    for (final message in messages) {
      _messages[message.id] = ServerRevMessage.fromMessage(message: message);
      _sentMessages.removeWhere((val) => val.idempotencyKey == message.nonce);
    }
    emitMessages();
  }

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

abstract class RevMessage {
  RevMessage({required this.content});

  final String content;
}

class ClientRevMessage implements RevMessage {
  ClientRevMessage({required this.content, required this.idempotencyKey});
  final String idempotencyKey;

  @override
  final String content;
}

class ServerRevMessage implements RevMessage {
  ServerRevMessage.fromMessage({required this.message});
  final Message message;
  @override
  String get content => message.content;
}
