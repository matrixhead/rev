part of 'chat_cubit.dart';

@Freezed(equal: false)
class ChatState with _$ChatState {
  const ChatState._();
  factory ChatState({
    final RevChannel? channel,
    final Iterable<RevMessage>? messages,
    final Iterable<RelationUser>? otherUsers,
  }) = _ChatState;

  String get title {
    if (otherUsers case final Iterable<RelationUser> otherUsers) {
      if (channel!.channelType == ChannelType.directMessage) {
        return otherUsers.first.username;
      }
    }

    return "";
  }
}
