import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:revolt_client/revolt_client.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

class ChatCubit extends Cubit<ChatState> {
  final RevoltClient client;

  StreamSubscription<Map<String, Message>>? _messagesStreamSubscription;

  ChatCubit({
    required this.client,
  }) : super(ChatState.initial());

  init(String channelId) async {
    final channel = await client.getChannelforId(channelId: channelId);
    emit(ChatState.channelLoaded(channel));
    channel.messages.listen(listenOnMessages);
  }

  sendMessage(String message){
    final loadedState = state as ChatStateChannelLoaded;
    client.sendMessage(channelId: loadedState.channel.id, content: message);
  }

  listenOnMessages(Map<String, Message> messages) {
    print("hi");
  }

  @override
  Future<void> close() {
    _messagesStreamSubscription?.cancel();
    return super.close();
  }
}
