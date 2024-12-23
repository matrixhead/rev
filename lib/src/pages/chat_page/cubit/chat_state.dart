part of 'chat_cubit.dart';

@Freezed(equal: false)
class ChatState with _$ChatState {
  factory ChatState({
    final RevChannel? channel,
    final Iterable<RevMessage>? messages,
    @Default("") final String title,
}) = _ChatState;
}
