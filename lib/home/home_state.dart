import 'package:flutter/material.dart';
import 'package:notifier_state/notifier_state.dart';

import '../services/some_service.dart';

import '../about.dart';
import 'home.dart';

class HomePageState extends StateController<HomePage> {
  Future<void> openContact() async {
    // final bytes = await context.toImage().then((value) => value.bytes());
    final bytes = await context.toImageBytes();
    bucket.get<SomeLazyService>().updateImageBytes(bytes);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AboutPage(),
      ),
    );
  }

  void test() async {
    final result = await nav.pushNamed(
      '/test',
      arguments: 'test arguments',
    );
    print(result);
    print(result.runtimeType);
  }

  void testDialog() async {}
}
