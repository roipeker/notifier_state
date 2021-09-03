import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notifier_state/notifier_state.dart';

class ContactPage extends StateWidget<ContactPageState> {
  @override
  createState() => ContactPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ContactMenu(),
      ),
    );
  }
}

class ContactPageState extends StateController<ContactPage> {
  @override
  void readyState() {
    print('Widget ready! /// $navigatorArguments');
    // navigator.pop(111);
    super.readyState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void tapCircle(int index) {
    print('Tap circle $index');
  }
}

class ContactMenu extends ParentStateWidget<ContactPageState> {
  ContactMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...List.generate(
          4,
          (index) {
            final isHover = false.obs();
            final isHighlight = false.obs();
            final onTapped = false.obs();
            return GestureDetector(
              onTap: () {
                onTapped(true);
                state.tapCircle(index);
              },
              child: FocusableActionDetector(
                mouseCursor: SystemMouseCursors.click,
                onShowFocusHighlight: isHighlight,
                onShowHoverHighlight: isHover,
                autofocus: true,
                descendantsAreFocusable: false,
                shortcuts: {
                  LogicalKeySet.fromSet({LogicalKeyboardKey.keyA}):
                      const ActivateIntent()
                },
                actions: {
                  ActivateIntent: CallbackAction(onInvoke: (_) {
                    onTapped(true);
                    state.tapCircle(index);
                  }),
                },
                child: Observer(
                  () => AnimatedContainer(
                    duration: Duration(milliseconds: onTapped() ? 200 : 400),
                    curve: onTapped() ? Curves.easeInOut : Curves.bounceOut,
                    transformAlignment: Alignment.center,
                    transform: onTapped()
                        ? (Matrix4.identity()..scale(.5, .5))
                        : Matrix4.identity(),
                    onEnd: () {
                      onTapped(false);
                    },
                    child: CircleAvatar(
                      child: Text('A'),
                      radius: isHover() ? 80 : 50,
                      backgroundColor:
                          isHighlight() ? Colors.lightBlueAccent : Colors.blue,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
