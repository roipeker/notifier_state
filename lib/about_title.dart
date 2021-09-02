import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notifier_state/notifier_state.dart';
import 'package:notifier_state_sample/about.dart';

class AboutTitleText extends ParentStateWidget<AboutPageState> {
  const AboutTitleText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// capture at 1x... is async.
    // state.capturePhoto(context, pixelRatio: 1);
    return Column(
      children: [
        Observer(() => Text("Parent state name: ${state.name}")),
        Divider(),
        ElevatedButton(
          onPressed: state.onChangeNamePress,
          child: Text('Change name'),
        ),
        Divider(),
        Builder(
          builder: (subcontext) {
            return ElevatedButton(
              onPressed: () async {
                final image = await subcontext.toImage(pixelRatio: 2, margin: EdgeInsets.all(4));
                state.saveImage(image);
              },
              child: Text('Capture button image (+margin)'),
            );
          },
        ),
        Divider(),
        ElevatedButton(
          onPressed: () async {
            final image = await context.toImage(
              pixelRatio: 2,
              margin: EdgeInsets.all(4),
            );
            state.saveImage(image);
          },
          child: Text('Capture $runtimeType image'),
        ),
        Divider(),
        Observer(
          () => state.isButtonShown()
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Time: ${state.tickerText}",
                      style: context.textTheme.headline6!),
                )
              : Icon(Icons.access_time),
        ),
      ],
    );
  }
}
