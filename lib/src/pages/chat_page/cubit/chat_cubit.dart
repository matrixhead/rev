import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:revolt_client/revolt_client.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

class ChatCubit extends Cubit<ChatState> {
  final RevoltClient client;

  StreamSubscription<Iterable<RevMessage>>? _messagesStreamSubscription;

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
    if(message.isEmpty){
      return;
    }
    client.sendMessage(channelId: state.channel!.id, content: message);
  }

  listenOnMessages(Iterable<RevMessage> messages) {
    final newState = state.copyWith(messages: messages);
    emit(newState);
  }

  @override
  Future<void> close() {
    _messagesStreamSubscription?.cancel();
    return super.close();
  }
}
