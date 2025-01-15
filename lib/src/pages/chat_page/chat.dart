import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rev/src/common/widgets/googly_eyes.dart';
import 'package:rev/src/pages/chat_page/cubit/chat_cubit.dart';
import 'package:rev/src/pages/home_page/cubit/home_cubit.dart';
import 'package:revolt_client/revolt_client.dart';

class ChatPageView extends StatelessWidget {
  const ChatPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () => context
                    .read<HomeCubit>()
                    .setPage(page: 0, withAnimation: true),
                child: Icon(Icons.arrow_back)),
            title: Text(state.title),
          ),
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

class MessagesList extends StatefulWidget {
  const MessagesList({
    super.key,
  });

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  late final ScrollController _controller;
  bool atEdge = false;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    atEdge =
        notification.metrics.pixels == notification.metrics.maxScrollExtent;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (atEdge) {
          _controller.jumpTo(
            _controller.position.maxScrollExtent,
          );
        }
      },
      builder: (context, state) {
        if (state.messages case Iterable<RevMessage> messages) {
          return NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:  8.0),
              child: ListView.builder(
                reverse: true,
                controller: _controller,
                itemBuilder: (context, index) {
                  final message = messages.elementAt(index);
                  return SizedBox(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              GooglyEyes(
                                  seed: state
                                      .userNameForId(message.author)
                                      .hashCode,
                                  size: 50),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      state.userNameForId(message.author),
                                      style:
                                          Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Flexible(child: Text(message.content)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
                itemCount: messages.length,
              ),
            ),
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
