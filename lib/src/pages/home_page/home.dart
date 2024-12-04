import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePageView();
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
            IconButton(onPressed: () {}, icon: Icon(Icons.person_add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Listitem(),
            ],
          ),
        ));
  }
}

class Listitem extends StatelessWidget {
  const Listitem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(Icons.person),
      SizedBox(width: 16,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Username"),
          Text("Online")
        ],
      )
      ],
    );
  }
}
