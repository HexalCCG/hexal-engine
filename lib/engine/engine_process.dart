import 'package:hexal_engine/model/actions/action.dart';
import 'package:hexal_engine/model/actions/pass_action.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/state_change/phase_state_change.dart';
import 'package:hexal_engine/model/state_change/priority_state_change.dart';
import 'package:hexal_engine/model/state_change/state_change.dart';
import 'package:hexal_engine/model/turn_phase.dart';

List<StateChange> engineProcess(GameState state, Action action) {
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
