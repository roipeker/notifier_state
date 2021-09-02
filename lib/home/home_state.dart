
import 'package:flutter/material.dart';
import 'package:notifier_state/notifier_state.dart';

import '../about.dart';
import 'home.dart';

/// --- controller.
class HomePageState extends StateController<HomePage> {
  void openContact() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AboutPage(),
      ),
    );
  }
}