class Engine {
  /// Is the action valid?
  bool actionAllowed(GameState state, Action action) {
    throw UnimplementedError();
  }

  /// Generates a list of changes following the provided action.
  List<StateChange> processAction(GameState state, Action action) {
    throw UnimplementedError();
  }

  /// Generates the next GameState following a state change.
  GameState applyStateChange(GameState state, StateChange stateChange) {
    throw UnimplementedError();
  }
}
