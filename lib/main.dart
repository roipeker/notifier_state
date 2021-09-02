import 'package:flutter/material.dart';

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
      home: const HomePage(),
    );
  }
}
