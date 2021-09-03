import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notifier_state/notifier_state.dart';

part 'test_state.dart';

class TestDialog extends StateWidget<TestState> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('test dialog'),
      actions: [
        CupertinoButton(
          child: Text('back'),
          onPressed: state.onBack,
        )
      ],
    );
  }

  @override
  TestState createState() => TestState();
}
