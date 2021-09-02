import 'package:flutter/material.dart';
import 'package:notifier_state/notifier_state.dart';
import 'package:notifier_state_sample/services/some_service.dart';

import '../about.dart';
import 'home.dart';

/// --- controller.
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

  void test() {
    toNamed('/test');
  }
}
