part of notifier_state;

/// Instead of `StatefulWidget`, and consumes a [StateController].
abstract class StateWidget<T extends State> extends StatefulWidget {
  const StateWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context);

  T get state => StateElement._elements[this] as T;

  @override
  StateElement createElement() => StateElement(this);

  @override
  T createState();
}

class StateElement extends StatefulElement {
  static final _elements = Expando('State Controllers');

  StateElement(StateWidget widget) : super(widget) {
    _elements[widget] = state;
  }

  @override
  void update(StatefulWidget newWidget) {
    _elements[newWidget] = state;
    super.update(newWidget);
  }

  @override
  StateWidget get widget => super.widget as StateWidget;

  @override
  Widget build() => widget.build(this);
}

/// use [StateController] instead of `State` for [StateWidget].
class StateController<T extends StateWidget> extends State<T>
    with DisposerMixin{
  @protected
  @override
  Widget build(BuildContext context) {
    throw "$runtimeType\.build() is invalid. Use <StateWidget.build()> instead.";
  }

  bool isInitialized = false;

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      isInitialized = true;
      onReady();
    });
  }

  void onReady() {}

  /// useless for now.
  void addDependant(BuildContext other) {}

  void removeDependant(BuildContext other) {}
}

/// Use instead of `StatelessWidget` to consume parent [StateControllers].
abstract class ParentStateWidget<T extends StateController>
    extends StatelessWidget {
  const ParentStateWidget({Key? key}) : super(key: key);

  T get state =>
      (StateElement._elements[this] as ParentStateElement)._otherState as T;

  @override
  ParentStateElement createElement() {
    assert(const Object() is! T, """
          You have to provide a subclass of StateController:
          $runtimeType extends ParentStateWidget<StateController>
       """);
    return ParentStateElement<T>(this);
  }
}

class ParentStateElement<T extends StateController> extends StatelessElement {
  late T _otherState;

  ParentStateElement(ParentStateWidget widget) : super(widget) {
    StateElement._elements[widget] = this;
  }

  bool _justMounted = true;

  @override
  void mount(Element? parent, Object? newSlot) {
    _justMounted = true;
    super.mount(parent, newSlot);
  }

  @override
  Widget build() {
    if (_justMounted) {
      // TODO: any other methods where the State changes it's position in the
      // todo: tree?
      final _state = findStateControllerProvider();
      if (_state == null) {
        throw """
        [ParentStateWidget] can't find a parent StateController <$T> dependency in the Widget tree.
        Make sure you have a StateWidget<$T> somewhere up the tree.
        """;
      }
      _otherState = _state;
      _justMounted = false;
    }
    return super.build();
  }

  @override
  void unmount() {
    _justMounted = false;
    _otherState.removeDependant(this);
    super.unmount();
  }

  @override
  void update(StatelessWidget newWidget) {
    StateElement._elements[newWidget] = this;
    super.update(newWidget);
  }

  T? findStateControllerProvider() {
    T? _state;
    visitAncestorElements((element) {
      if (element is StateElement && element.state is T) {
        _state = element.state as T;
        return false;
      }
      return true;
    });
    return _state;
  }

  @override
  ParentStateWidget get widget => super.widget as ParentStateWidget;
}
