import 'package:flutter/material.dart';
import 'package:notifier_state/notifier_state.dart';
import 'package:notifier_state_sample/services/some_service.dart';

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
              child: Text('about'),
              onPressed: state.openAbout,
            ),
            TextButton(
              child: Text('contact'),
              onPressed: state.openContact,
            ),
            TextButton(
              child: Text('bottom nav page'),
              onPressed: state.openBottomNavPage,
            ),
            Text('Hello'),
            const Divider(),
            Text('flag: ${state.flag}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bucket.get<SomeNavService>().selectedBottom.value=0;
          // state.removePage();
        },
        tooltip: 'Reset Navigation Index',
        heroTag: '$hashCode',
        child: Icon(Icons.clear), //Change Icon
      ),
    );
  }
}
