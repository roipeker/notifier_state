import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:notifier_state/notifier_state.dart';
import 'package:notifier_state_sample/services/some_service.dart';

import 'about_title.dart';

mixin RouteBuilderMixin<C extends StateController> on StateWidget<C> {
  String? get routeName;

  Route<T?> createRoute<T>({Object? arguments}) {
    return RouteBuilder.material<T>(
      builder: (_) => this,
      name: routeName,
      arguments: arguments,
    );
  }
}

class AboutPage extends StateWidget<AboutPageState> with RouteBuilderMixin {
  @override
  final routeName = '/about';

  const AboutPage({Key? key}) : super(key: key);

  @override
  createState() => AboutPageState();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<EventNotification>(
      onNotification: (data) {
        print("event data: $data");
        return false;
      },
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Observer(
                  () => Column(
                    children: [
                      Text('Behold the capture:'),
                      if (state.hasImage)
                        Container(
                          color: Colors.white,
                          // padding: EdgeInsets.all(2),
                          child: Image.memory(
                            state.imageBytes!,
                            scale: 2,
                          ),
                        ),
                    ],
                  ),
                ),
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
                Container(
                  width: 300,
                  child: AboutTitleText(),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RouteBuilder {
  static Route<T?> material<T extends Object?>({
    required WidgetBuilder builder,
    Object? arguments,
    String? name,
  }) {
    return MaterialPageRoute<T?>(
      builder: builder,
      settings: RouteSettings(arguments: arguments, name: name),
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

  bool get hasImage => imageBytes != null;

  Uint8List? get imageBytes {
    return bucket.get<SomeLazyService>().imgProvider();
  }

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

  void saveImage(ui.Image img) async {
    final service = bucket<SomeLazyService>();
    service.updateImageBytes(await img.bytes());
  }

  void capturePhoto(BuildContext ctx, {double pixelRatio = 1}) async {
    final image = await ctx.toImage(
      pixelRatio: pixelRatio,
    );
    saveImage(image);
  }
}
