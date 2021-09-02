import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notifier_state/notifier_state.dart';
import 'package:notifier_state_sample/services/some_service.dart';

import 'about_title.dart';

class AboutPage extends StateWidget<AboutPageState> {
  const AboutPage({Key? key}) : super(key: key);

  @override
  AboutPageState createState() => AboutPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Observer(
            () => Visibility(
              visible: !state.isButtonShown(),
              child: IconButton(
                onPressed: state.isButtonShown.toggle,
                icon: Icon(Icons.add_location),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('state name (not updated): ${state.name}'),
            Divider(),
            Text('Lazy service: "${state.lazyServiceName}"'),
            Divider(),
            Text('Factory service: "${state.factoryServiceNameAndHash}"'),
            Container(
              padding: EdgeInsets.all(16),
              child: Observer(() => Text('Ticker: ${state.tickerText}')),
            ),
            Divider(),
            Observer(() =>
                Switch(value: state.switcher(), onChanged: state.switcher)),
            Divider(),
            Observer(
              () => state.isButtonShown() || state.switcher()
                  ? IconButton(
                      onPressed: state.isButtonShown.toggle,
                      icon: Icon(Icons.add_location),
                    )
                  : Container(),
            ),
            Divider(),
            AboutTitleText(),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class AboutPageState extends StateController<AboutPage>
    with DisposerMixin, SingleTickerProviderStateMixin {
  late final name = 'Yo'.obs(disposer: this);
  final tickerText = NotifierValue(Duration.zero);
  late final switcher = false.obs(onChange: onSwitchChange);
  late final isButtonShown = true.obs(onChange: onButtonShown);
  late final Ticker _ticker = createTicker(tickerText);

  @override
  void initState() {
    _ticker.start();
    super.initState();
  }

  String get lazyServiceName => bucket<SomeLazyService>().name;

  String get factoryServiceNameAndHash =>
      bucket.get<SomeFactoryService>().getNameHash();

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void onChangeNamePress() {
    name.value += 'o';
  }

  /// a mess of switchers.
  void onButtonShown(bool state) {
    /// it will overflow.
    // Future.microtask(() => switcher(state));
  }

  void onSwitchChange(bool state) {
    print("Switch change! $state");
    Future.microtask(() => isButtonShown(!state));
  }
}
