import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:revolt_client/revolt_client.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

class ChatCubit extends Cubit<ChatState> {
  final RevoltClient client;

  StreamSubscription<Iterable<RevMessage>>? _messagesStreamSubscription;
  StreamSubscription<Map<String,RelationUser>>? _otherUsersStreamSubscription;

  ChatCubit({
    required this.client,
  }) : super(ChatState());

  init(String channelId) async {
    final channel = await client.getChannelforId(channelId: channelId);

    _messagesStreamSubscription = channel.messages.listen(listenOnMessages);
    _otherUsersStreamSubscription =
        client.getOtherUsersForChannel(channel).listen(listenOnOtherUsers);
    client.fetchMessages(id: channelId);
    emit(state.copyWith(currentUser: await client.fetchSelf()));
    emit(state.copyWith(channel: channel));
  }

  sendMessage(String message) {
    if (message.isEmpty) {
      return;
    }
    client.sendMessage(channelId: state.channel!.id, content: message);
  }

  listenOnMessages(Iterable<RevMessage> messages) {
    final newState = state.copyWith(messages: messages);
    emit(newState);
  }

  void listenOnOtherUsers(Map<String,RelationUser> relationUsers) {
    final newState = state.copyWith(otherUsers: relationUsers);
    emit(newState);
  }

  @override
  Future<void> close() {
    _messagesStreamSubscription?.cancel();
    _otherUsersStreamSubscription?.cancel();
    return super.close();
  }
}
