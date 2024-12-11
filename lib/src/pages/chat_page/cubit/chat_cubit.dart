import 'dart:async';
import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:revolt_client/revolt_client.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

class ChatCubit extends Cubit<ChatState> {
  final RevoltClient client;

  StreamSubscription<LinkedHashMap<String, Message>>?
      _messagesStreamSubscription;

  ChatCubit({
    required this.client,
  }) : super(ChatState());

  init(String channelId) async {
    final channel = await client.getChannelforId(channelId: channelId);
    emit(ChatState(channel));
    _messagesStreamSubscription = channel.messages.listen(listenOnMessages);
    client.fetchMessages(id: channelId);
  }

  sendMessage(String message) {
    client.sendMessage(channelId: state.channel!.id, content: message);
  }

  listenOnMessages(LinkedHashMap<String, Message> messages) {
    emit(state.copyWith(messages: messages));
  }

  @override
  Future<void> close() {
    _messagesStreamSubscription?.cancel();
    return super.close();
  }
}
