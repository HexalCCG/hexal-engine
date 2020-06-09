import 'package:hexal_engine/state_change/phase_state_change.dart';
import 'package:hexal_engine/state_change/priority_state_change.dart';

import '../state_change/state_change.dart';
import '../game_state.dart';
import '../turn_phase.dart';
import 'action.dart';

class PassAction extends Action {
  const PassAction();

  @override
  List<Object> get props => [];

  @override
  List<StateChange> apply(GameState state) {
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
}
