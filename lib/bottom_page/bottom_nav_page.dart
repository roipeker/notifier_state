// =================================================================================================
//
//  notifier_state
//	Created by roi [roipeker™] on 02/09/2021 21:41.
//
// =================================================================================================

import 'package:flutter/material.dart';
import 'package:notifier_state/notifier_state.dart';
import 'package:notifier_state_sample/services/some_service.dart';

import 'bottom_child_page.dart';

class BottomNavPage extends StateWidget<BottomNavPageState> {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  BottomNavPageState createState() => BottomNavPageState();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NotificationListener<EventNotification>(
        onNotification: state.onBottomChildRemove,
        child: Stack(
          children: [
            Row(
              children: [
                ...List.generate(
                  state.activePages,
                  (index) => Expanded(
                    child: const BottomChildPage(),
                  ),
                ),
              ],
            ),
            Material(
              type: MaterialType.transparency,
              child: Center(
                heightFactor: 20,
                child: Observer(
                  () => Text('Selected item ${state.bottomItem}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavPageState extends StateController<BottomNavPage> {
  final bottomItem = 0.obs();

  // late NotifierValue<int> bottomItem;
  int activePages = 5;

  void removePage() {
    setState(() {
      activePages--;
    });
  }

  @override
  void readyState() {
    print("WE ARE READY >>> $hashCode");
    // print('Item data: ${bottomItem()}');
    // final rx = bucket.get<SomeNavService>().selectedBottom;
    // rx.addValueListener(_onChange);
    // bottomItem = bucket.get<SomeNavService>().selectedBottom;
    bucket.get<SomeNavService>().selectedBottom.addValueListener(bottomItem);
  }

  // void _onChange(v) {
  //   // print("WHT is used?! ?// ${bottomItem}//$v");
  //   bottomItem.value = v;
  //   // bottomItem(v);
  // }

  @override
  void dispose() {
    bucket.get<SomeNavService>().selectedBottom.removeValueListener(bottomItem);
    // final rx = bucket.get<SomeNavService>().selectedBottom;
    // final res = rx.removeValueListener(_onChange);
    // print("DISPOSED!? // rx=$rx /// disposed=$res");
    // print("Service is the same?! ${rx == bottomItem}");
    bottomItem.dispose();
    super.dispose();
  }

  bool onBottomChildRemove(EventNotification notification) {
    if (notification.type == 'remove') {
      removePage();
    }
    return false;
  }
}
