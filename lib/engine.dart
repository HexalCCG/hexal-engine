import 'actions/action.dart';
import 'game_state.dart';
import 'state_change/state_change.dart';

class Engine {
  static List<StateChange> processAction(GameState state, Action action) =>
      action.apply(state);

  static GameState processStateChange(
          GameState state, List<StateChange> changes) =>
      changes.fold(state, (currentState, change) => change.apply(currentState));
}
