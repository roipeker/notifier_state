import 'package:flutter/material.dart';
import 'package:notifier_state/notifier_state.dart';
import 'package:notifier_state_sample/bottom_page/bottom_nav_page.dart';
import 'package:notifier_state_sample/contact/contact_page.dart';
import 'package:notifier_state_sample/services/some_service.dart';

import '../about.dart';
import 'home.dart';

/// --- controller.
class HomePageState extends StateController<HomePage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // print( "All ready!");
    // print(navigatorArguments);
    // print(context.dirty);
    // print(navigator);
    // Future.delayed(Duration(seconds: 1), (){
    //   navigator.push( AboutPage().createRoute() );
    // });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // final nav = Navigator.of(context);
    // openContact();
    // print('Init stage! $context // $nav');
    // print();
    super.initState();
  }

  Future<void> openContact() async {
    final res = await navigator.push<int?>(MaterialPageRoute(
        builder: (_) => ContactPage(),
        settings: RouteSettings(
          arguments: 123,
        )));
    print("openContact: $res");
  }

  bool flag = false;

  Future<void> openAbout() async {
    navigator.push(AboutPage().createRoute(arguments: 123));

    flag = !flag;

    return;
    // final bytes = await context.toImage().then((value) => value.bytes());

    final bytes = await context.toImageBytes();
    bucket.get<SomeLazyService>().updateImageBytes(bytes);

    final builder = PageRouteBuilder(
        pageBuilder: (_, a, b) => AboutPage(),
        maintainState: false,
        barrierColor: Colors.red,
        fullscreenDialog: false,
        transitionDuration: Duration(seconds: 1),
        reverseTransitionDuration: Duration(seconds: 1),
        transitionsBuilder: (ctx, a, b, c) {
          print(a.status);
          final curve = a.status == AnimationStatus.forward
              ? Curves.easeOutBack
              : Curves.easeOutExpo;
          final tweenScale =
              Tween<double>(begin: 0.0, end: 0).chain(CurveTween(curve: curve));
          final tweenOpacity = CurveTween(curve: curve);
          final seq = TweenSequence([
            TweenSequenceItem(tween: tweenScale, weight: .85),
            TweenSequenceItem(tween: tweenOpacity, weight: .2),
          ]);
          return ScaleTransition(
            scale: a.drive(seq),
            alignment: Alignment.bottomLeft,
            child: FadeTransition(
              opacity: a,
              child: c,
            ),
          );
        });
    final res = await Navigator.of(context).push(
      // builder,
      MaterialPageRoute(
        builder: (_) => AboutPage(),
        maintainState: false,
      ),
    );
    print(res);
  }

  void openBottomNavPage() {
    navigator.push(
      MaterialPageRoute(
        builder: (_) => BottomNavPage(),
        maintainState: false,
      ),
    );
  }
}
