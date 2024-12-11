part of 'chat_cubit.dart';

@freezed
class ChatState with _$ChatState {
  factory ChatState(
      [RevChannel? channel,
      LinkedHashMap<String, Message>? messages]) = _ChatState;
}
