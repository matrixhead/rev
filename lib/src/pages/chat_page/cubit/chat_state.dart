part of 'chat_cubit.dart';

@Freezed(equal: false)
class ChatState with _$ChatState {
  const ChatState._();
  factory ChatState({
    final RevChannel? channel,
    final Iterable<RevMessage>? messages,
    final Map<String,RelationUser>? otherUsers,
    final CurrentUser? currentUser,
  }) = _ChatState;

  String get title {
    if (otherUsers case final Map<String,RelationUser> otherUsers) {
      if (channel!.channelType == ChannelType.directMessage) {
        return otherUsers.values .first.username;
      }
    }
    return "loading";
  }

  String userNameForId(String id) {
    return otherUsers![id]?.username ?? currentUser!.username;
  }
}
