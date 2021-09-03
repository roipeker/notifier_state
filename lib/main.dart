import 'package:flutter/material.dart';
import 'test/test_page.dart';

import 'home/home.dart';
import 'services/some_service.dart';

void main() {
  initServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        navigatorObserver,
      ],
      initialRoute: '/',
      routes: {
        '/': HomePage.create,
        '/test': TestPage.create,
      },
      onUnknownRoute: (e) {
        print(e.name);
      },
    );
  }

  final navigatorObserver = RouteObserver();
}
