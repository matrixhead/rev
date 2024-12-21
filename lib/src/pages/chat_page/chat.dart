import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebar/src/pages/chat_page/cubit/chat_cubit.dart';
import 'package:revolt_client/revolt_client.dart';



class ChatPageView extends StatelessWidget {
  const ChatPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          body: state.channel != null
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
      children: [Expanded(child: MessagesList()), BottomBar()],
    );
  }
}

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state.messages case Iterable<RevMessage> messages) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return SizedBox(
                  height: 50,
                  child: Card(
                    child: Text(messages.elementAt(index).content),
                  ));
            },
            itemCount: messages.length,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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
