import 'package:notifier_state/notifier_state.dart';

import 'test_page.dart';

class TestPageState extends StateController<TestPage> {
  @override
  void initState() {
    super.initState();
    // print(arguments);
  }

  @override
  void onReady() {
    print(arguments);
  }

  void onBack() {
    nav.pop('this is a result');
  }
}
