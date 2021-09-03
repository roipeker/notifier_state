import 'package:flutter/material.dart';
import 'package:notifier_state/notifier_state.dart';
import 'test_state.dart';

class TestPage extends StateWidget<TestPageState> {
  const TestPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const TestPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Center(
        child: TextButton(
          child: Text('back'),
          onPressed: state.onBack,
        ),
      ),
    );
  }

  @override
  TestPageState createState() => TestPageState();
}
