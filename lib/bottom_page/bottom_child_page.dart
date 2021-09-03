import 'package:flutter/material.dart';
import 'package:notifier_state/notifier_state.dart';
import 'package:notifier_state_sample/services/some_service.dart';

// class BottomChildPage extends StatelessWidget with ParentStateMixin<BottomNavPageState> {
class BottomChildPage extends StatelessWidget {
  const BottomChildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int _index =0;
    final service = bucket.get<SomeNavService>();
    final value = context.listen(service.selectedBottom);
    final screenIndex = 2;
    print('REBUILD!');
    // final value = service.selectedBottom.subscribe(context);
    // final value = state.bottomItem.listen(context);
    // final value = 0;
    // print("listen to value: $value");
    return Scaffold(
      appBar: AppBar(
        title: Text('appbarTitle'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You are looking at the message for bottom navigation item $value',
              ),
              const _InnerTextChild(),
            ],
          ),
        ),
      ),
          // https://roi-notifier-state-1-web.surge.sh/#/
      bottomNavigationBar: BottomNavigationBar(
          onTap: service.selectedBottom,
          // onTap: (index) {
          // print("SelecteD: ${service.selectedBottom}");
          // state.bottomItem(index);
          // },
          currentIndex: value,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.av_timer), title: Text('navBarItem1Text')),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), title: Text('navBarItem2Text'))
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.notifyData(RemoveScreenNotification());
          context.notifyEvent('remove', data: screenIndex);
        },
        tooltip: 'Reset Navigation Index',
        heroTag: '${DateTime.now()}',
        child: Icon(Icons.clear), //Change Icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, //Change for different locations
    );
  }
}

class RemoveScreenNotification extends Notification {}

class _InnerTextChild extends StatelessWidget {
  const _InnerTextChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = bucket<SomeNavService>().selectedBottom.subscribe(context);
    return Container(
      padding: EdgeInsets.all(8),
      child: Text('selected is $value'),
    );
  }
}
