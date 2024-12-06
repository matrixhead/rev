import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebar/src/pages/home_page/cubit/home_cubit.dart';
import 'package:revolt_client/revolt_client.dart';

class HomePage extends StatelessWidget {
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
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.recent_actors),
          title: Text("Friends"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.add_comment)),
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () => _dialogBuilder(context,
                      onSubmit: context.read<HomeCubit>().submitFriendRequest),
                  icon: Icon(Icons.person_add));
            })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Listitem(
                      user: state.friendsList.values.elementAt(index));
                },
                itemCount: state.friendsList.length,
              );
            },
          ),
        ));
  }

  Future<void> _dialogBuilder(BuildContext context,
      {required Function(String) onSubmit}) {
    return showDialog<void>(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return AddFriendDialog(onSubmit: onSubmit);
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
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Ok'),
          onPressed: () {
            widget.onSubmit(_controller.text);
            Navigator.of(context).pop();
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
    return Row(
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
    );
  }
}
