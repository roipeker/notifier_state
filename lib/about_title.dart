import 'package:flutter/material.dart';
import 'package:notifier_state/notifier_state.dart';
import 'package:notifier_state_sample/about.dart';

class AboutTitleText extends ParentStateWidget<AboutPageState> {
  const AboutTitleText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(() => Text("Parent state name: ${state.name}")),
        Divider(),
        ElevatedButton(
          onPressed: state.onChangeNamePress,
          child: Text('Change name'),
        ),
        Divider(),
        Observer(
          () => state.isButtonShown()
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Time: ${state.tickerText}",
                        style: context.textTheme.headline6!),
                  ),
                )
              : Icon(Icons.access_time),
        ),
      ],
    );
  }
}
