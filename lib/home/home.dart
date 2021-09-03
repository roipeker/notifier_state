import 'package:flutter/material.dart';
import 'package:notifier_state/notifier_state.dart';

import 'home_state.dart';

@CustomRoute('/')
class HomePage extends StateWidget<HomePageState> {
  const HomePage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const HomePage();

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
            TextButton(
              onPressed: state.test,
              child: Text('state'),
            ),
            TextButton(
              onPressed: state.testDialog,
              child: Text('test dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
