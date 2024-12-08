part of 'chat_cubit.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = ChatStateInitial;
  const factory ChatState.channelLoaded(EnrichedChannel channel) = ChatStateChannelLoaded;
}
