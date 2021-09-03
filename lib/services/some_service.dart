import 'dart:typed_data';

import 'package:notifier_state/notifier_state.dart';

final bucket = Bucket.instance;

void initServices() {
  bucket.lazyPut(() => SomeLazyService());
  bucket.factory(() => SomeFactoryService());
}

class SomeFactoryService {
  final name = 'Some factory';

  SomeFactoryService() {
    print('Creating $this');
  }

  String getNameHash() {
    return '$runtimeType ($name) - hash= $hashCode';
  }
}

class SomeLazyService {
  final imgProvider = NotifierValue<Uint8List?>(null);

  Uint8List? oldBytes;
  void updateImageBytes(Uint8List img) {
    final dd = imgProvider.value;
    imgProvider(img);
  }

  final name = 'Some lazy service';

  SomeLazyService() {
    print('Creating $this');
    // imgProvider.addListener(() {
    //   print('new data arrived! ${imgProvider.value!.length}');
    // });
  }
}
