import 'package:flutter/material.dart';
import 'package:notifier_state/notifier_state.dart';

import 'home_state.dart';

class HomePage extends StateWidget<HomePageState> {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text('Hello'),
              onPressed: state.openContact,
            ),
            const Divider(),
            Text('Hello'),
          ],
        ),
      ),
    );
  }
}
