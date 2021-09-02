part of notifier_state;

class DataNotification<T> extends Notification {
  final T data;
  const DataNotification(this.data);
  @override
  void debugFillDescription(List<String> info) {
    super.debugFillDescription(info);
    info.add('$data');
  }
}

class EventNotification extends Notification {
  static final _map = <String?, EventNotification>{};

  static EventNotification get(String id, {Object? data}) {
    if (!_map.containsKey(id)) {
      _map[id] = EventNotification(id, data: data);
    }
    final o = _map[id]!;
    o.data = data;
    return o;
  }

  String type;
  Object? data;

  EventNotification(this.type, {this.data});

  @override
  void debugFillDescription(List<String> info) {
    super.debugFillDescription(info);
    info.addAll([type, if (data != null) '$data']);
  }
}
