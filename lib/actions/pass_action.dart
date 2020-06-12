import '../game_state/game_state.dart';
import '../game_state/turn_phase.dart';
import '../state_change/active_player_state_change.dart';
import '../state_change/phase_state_change.dart';
import '../state_change/priority_state_change.dart';
import '../state_change/state_change.dart';
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
      // Move on to the next turn
      return [
        ActivePlayerStateChange(player: state.notActivePlayer),
        PhaseStateChange(phase: TurnPhase.start),
        PriorityStateChange(player: state.notActivePlayer)
      ];
    }
  }
}