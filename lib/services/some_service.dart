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
  final name = 'Some lazy service';
  SomeLazyService() {
    print('Creating $this');
  }
}
