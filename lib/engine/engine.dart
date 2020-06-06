import 'package:hexal_engine/model/actions/action.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/state_change.dart';

class Engine {
  /// Is the action valid?
  static bool actionAllowed(GameState state, Action action) {
    throw UnimplementedError();
  }

  /// Generates a list of changes following the provided action.
  static List<StateChange> processAction(GameState state, Action action) {
    throw UnimplementedError();
  }

  /// Generates the next GameState following a state change.
  static GameState applyStateChange(GameState state, StateChange stateChange) {
    throw UnimplementedError();
  }
}
