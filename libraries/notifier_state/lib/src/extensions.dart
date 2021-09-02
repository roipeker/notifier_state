part of notifier_state;

extension NotifierIntX on int {
  NotifierValue<int> obs({
    DisposerNotifier? disposer,
    ValueChanged<int>? onChange,
  }) {
    final o = NotifierValue<int>(this)..hookDispose(disposer);
    if (onChange != null) {
      o.addValueListener(onChange);
    }
    return o;
  }
}

extension NotifierDoubleX on double {
  NotifierValue<double> obs({
    DisposerNotifier? disposer,
    ValueChanged<double>? onChange,
  }) {
    final o = NotifierValue<double>(this)..hookDispose(disposer);
    if (onChange != null) {
      o.addValueListener(onChange);
    }
    return o;
  }
}

extension NotifierStringX on String {
  NotifierValue<String> obs({
    DisposerNotifier? disposer,
    ValueChanged<String>? onChange,
  }) {
    final o = NotifierValue<String>(this)..hookDispose(disposer);
    if (onChange != null) {
      o.addValueListener(onChange);
    }
    return o;
  }
}

extension NotifierBoolX on bool {
  NotifierValue<bool> obs({
    DisposerNotifier? disposer,
    ValueChanged<bool>? onChange,
  }) {
    final o = NotifierValue<bool>(this);
    o.hookDispose(disposer);
    if (onChange != null) {
      o.addValueListener(onChange);
    }
    return o;
  }
}

extension NotifierValueBoolX on NotifierValue<bool> {
  bool get isTrue => value;

  bool get isFalse => !isTrue;

  bool operator &(bool other) => other && value;

  bool operator |(bool other) => other || value;

  bool operator ^(bool other) => !other == value;

  void toggle() {
    value = !value;
  }
}

extension NotifierValueInterfaseX<T extends IValueNotifier> on T {
  NotifierValue<T> obs({
    DisposerNotifier? disposer,
    ValueChanged<T>? onChange,
  }) {
    final o = NotifierValue<T>(this)..hookDispose(disposer);
    if (onChange != null) {
      o.addValueListener(onChange);
    }
    return o;
  }
}

/// --- notifications.
/// Consume with [NotificationListener<Type>()] Widget.
extension ContextNotificationX on BuildContext {
  EventNotification notifyEvent(String type, {Object? data}) =>
      EventNotification.get(type, data: data)..dispatch(this);

  void notifyData<T>(T event) => DataNotification(event).dispatch(this);
}

extension BuildContextX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  Size? get size => this.size;
}
