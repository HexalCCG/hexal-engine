import 'actions/action.dart';
import 'actions/pass_action.dart';
import 'game_state.dart';
import 'state_change/phase_state_change.dart';
import 'state_change/priority_state_change.dart';
import 'state_change/state_change.dart';
import 'turn_phase.dart';

class Engine {
  /// Generates a list of changes following the provided action.
  static List<StateChange> processAction(GameState state, Action action) {
    // Handle pass action
    if (action is PassAction) {
      if (state.priorityPlayer == state.activePlayer) {
        // Pass priority to the other player
        return [PriorityStateChange(player: state.notPriorityPlayer)];
      } else if (state.turnPhase != TurnPhase.end) {
        // Move on to the next phase
        return [
          PhaseStateChange(phase: TurnPhase.values[state.turnPhase.index + 1]),
          PriorityStateChange(player: state.activePlayer)
        ];
      } else {
        throw UnimplementedError();
        // Move on to the next turn
        return [
          // TODO add active player change
          PhaseStateChange(phase: TurnPhase.values[state.turnPhase.index + 1]),
          PriorityStateChange(player: state.activePlayer)
        ];
      }
    }

    // Unhandled action types error
    throw UnimplementedError();
  }

  static GameState processStateChange(
      GameState state, List<StateChange> changes) {
    changes.forEach((change) {
      state = change.apply(state);
    });
    return state;
  }
}
