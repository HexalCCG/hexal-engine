import 'package:hexal_engine/model/actions/action.dart';
import 'package:hexal_engine/model/actions/pass_action.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/state_change/priority_state_change.dart';
import 'package:hexal_engine/model/state_change/state_change.dart';

class Engine {
  /// Is the action valid?
  static bool validate(GameState state, Action action) {
    if (action is PassAction) {
      return true;
    }
    throw UnimplementedError();
  }

  /// Generates a list of changes following the provided action.
  static StateChange processAction(GameState state, Action action) {
    // Check that action is valid
    if (!validate(state, action)) {
      throw ArgumentError('Provided action is not valid.');
    }

    // Handle pass action
    if (action is PassAction) {
      if (state.priorityPlayer == state.activePlayer) {
        return PriorityStateChange(player: state.notPriorityPlayer);
      } else {
        // TODO
      }
    }

    // Unhandled action types error
    throw UnimplementedError();
  }

  /// Generates the next GameState following a state change.
  static GameState applyStateChange(GameState state, StateChange stateChange) {
    throw UnimplementedError();
  }
}
