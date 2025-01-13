import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rev/src/common/bloc/app_bloc.dart';
import 'package:rev/src/pages/chat_page/chat.dart';
import 'package:rev/src/pages/home_page/cubit/home_cubit.dart';
import 'package:revolt_client/revolt_client.dart';

class HomePage extends StatelessWidget {
  static const route = "/home";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(client: context.read<RevoltClient>()),
      child: HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return BackButtonListener(
          onBackButtonPressed: () async {
            if (state.page.pageNumber == 0) {
              return false;
            } else {
              context.read<HomeCubit>().setPage(page: 0, withAnimation: true);
              return true;
            }
          },
          child: Stack(
            children: [Stage(), ChatOverlay()],
          ),
        );
      },
    );
  }
}

class ChatOverlay extends StatefulWidget {
  const ChatOverlay({
    super.key,
  });

  @override
  State<ChatOverlay> createState() => _ChatOverlayState();
}

class _ChatOverlayState extends State<ChatOverlay> {
  late final PageController _pageController;
  late final PageStorageBucket _bucket;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _bucket = PageStorageBucket();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return previous.currentSelectedChannel !=
            current.currentSelectedChannel;
      },
      builder: (context, state) {
        return BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.page
                case PageStateWithAnimation(pageNumber: int pageNumber)) {
              _pageController.animateToPage(pageNumber,
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOut);
            }
          },
          child: PageStorage(
            bucket: _bucket,
            child: Builder(builder: (context) {
              return PageView.builder(
                onPageChanged: (int page) {
                  context
                      .read<HomeCubit>()
                      .setPage(page: page, withAnimation: false);
                },
                controller: _pageController,
                hitTestBehavior: state.page.pageNumber == 0
                    ? HitTestBehavior.translucent
                    : HitTestBehavior.opaque,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SizedBox.expand();
                  }
                  return BlocProvider.value(
                    value: context
                        .read<HomeCubit>()
                        .chatCubitChannelMappings
                        .getorCreateCubit(
                            channelid: state.currentSelectedChannel!),
                    child: ChatPageView(
                      key: PageStorageKey(state.currentSelectedChannel),
                    ),
                  );
                },
                itemCount: state.currentSelectedChannel == null ? 1 : 2,
              );
            }),
          ),
        );
      },
    );
  }
}

class Stage extends StatelessWidget {
  const Stage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onLongPress: () async {
                final user = await context.read<RevoltClient>().fetchSelf();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${user.username}#${user.discriminator}'),
                  duration: const Duration(seconds: 1),
                ));
              },
              child: Icon(Icons.recent_actors)),
          title: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return GestureDetector(
                  onDoubleTap: () {
                    final snackBar = SnackBar(
                      content: Text('Currently on patch ${state.patchNumber}.'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text("Friends"));
            },
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.add_comment)),
            IconButton(
                onPressed: () => _addFriendDialog(
                      context,
                      onSubmit: context.read<HomeCubit>().submitFriendRequest,
                    ),
                icon: Icon(Icons.person_add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Column(
                children: [
                  InkWell(
                    child: IncomingFriendsBanner(),
                    onTap: () => _pendingRequestDialog(context),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Listitem(user: state.friends.elementAt(index));
                      },
                      itemCount: state.friends.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}

Future<void> _addFriendDialog(BuildContext context,
    {required Function(String) onSubmit}) {
  return showDialog<void>(
    context: context,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return AddFriendDialog(onSubmit: onSubmit);
    },
  );
}

Future<void> _pendingRequestDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    useRootNavigator: true,
    builder: (_) {
      return PendingRequestDialog(homeCubit: context.read<HomeCubit>());
    },
  );
}

class IncomingFriendsBanner extends StatelessWidget {
  const IncomingFriendsBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.incomingFriends.isEmpty
            ? SizedBox.shrink()
            : SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Pending requests"), Icon(Icons.arrow_right)],
                ),
              );
      },
    );
  }
}

class AddFriendDialog extends StatefulWidget {
  final Function(String) onSubmit;
  const AddFriendDialog({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AddFriendDialog> createState() => _AddFriendDialogState();
}

class _AddFriendDialogState extends State<AddFriendDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add friend'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("USERNAME"),
          TextField(
            controller: _controller,
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancel'),
          onPressed: () {
            context.pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Ok'),
          onPressed: () {
            widget.onSubmit(_controller.text);
            context.pop();
          },
        ),
      ],
    );
  }
}

class Listitem extends StatelessWidget {
  final RelationUser user;
  const Listitem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<HomeCubit>().onSelectUser(user.id),
      child: Row(
        children: [
          Icon(Icons.person),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.username),
              Text(user.online ? "Online" : "Offline")
            ],
          )
        ],
      ),
    );
  }
}

class PendingRequestDialog extends StatelessWidget {
  final HomeCubit homeCubit;
  const PendingRequestDialog({super.key, required this.homeCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeCubit,
      child: Dialog(
          child: AspectRatio(
        aspectRatio: 1.5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pending requests"),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final user = state.incomingFriends.elementAt(index);
                        return ListTile(
                          dense: true,
                          title: Text(user.username),
                          subtitle: Text("Incoming friend request"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    homeCubit.acceptFriendRequest(user.id);
                                    context.pop();
                                  },
                                  icon: Icon(Icons.add)),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.close)),
                            ],
                          ),
                        );
                      },
                      itemCount: state.incomingFriends.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
