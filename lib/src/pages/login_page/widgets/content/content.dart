import 'package:flutter/material.dart';
import 'package:rebar/src/pages/login_page/widgets/content/login_form.dart';
import 'package:rebar/src/pages/login_page/widgets/widgets.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CustomScrollView(
          //   slivers: [
          //     // Header()
          //   ],
          // ),
          Text(
            "Logo",
            // style: Theme.of(context).textTheme.headline1,
          ),
          const LoginForm(),
          ElevatedButton(onPressed: () {}, child: const Text("Login"))
        ],
      ),
    );
  }
}
