part of 'test_dialog.dart';



// import 'test_dialog.dart';
class TestState extends StateController<TestDialog> {
  @override
  void onReady() {
    print(arguments);
  }

  void onBack() {
    nav.pop('result from dialog');
  }
}
