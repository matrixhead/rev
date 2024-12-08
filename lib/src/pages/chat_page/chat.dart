import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebar/src/pages/chat_page/cubit/chat_cubit.dart';
import 'package:revolt_client/revolt_client.dart';

class ChatPage extends StatefulWidget {
  final String channelId;
  const ChatPage({super.key, required this.channelId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatCubit chatCubit;
  @override
  void initState() {
    chatCubit = ChatCubit(
      client: context.read<RevoltClient>(),
    )..init(widget.channelId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatCubit,
      child: const ChatPageView(),
    );
  }
}

class ChatPageView extends StatelessWidget {
  const ChatPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          body: state is ChatStateChannelLoaded
              ? ChatPageBody()
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class ChatPageBody extends StatelessWidget {
  const ChatPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: Placeholder()), BottomBar()],
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _controller,
            )),
            IconButton(
                onPressed: () {
                  context.read<ChatCubit>().sendMessage(_controller.text);
                  _controller.clear();
                },
                icon: Icon(Icons.send))
          ],
        ),
      ),
    );
  }
}
