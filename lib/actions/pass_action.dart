import '../game_state/game_state.dart';
import '../state_change/combination/next_phase_state_changes.dart';
import '../state_change/priority_state_change.dart';
import '../state_change/state_change.dart';
import 'action.dart';

class PassAction extends Action {
  const PassAction();

  @override
  List<StateChange> apply(GameState state) {
    if (state.priorityPlayer == state.activePlayer) {
      // Active player has passed so check for non-active response
      return [PriorityStateChange(player: state.notPriorityPlayer)];
    } else if (state.stack.isNotEmpty) {
      // Non-active player has passed so resolve top stack event and switch priority
      return [
        ...state.resolveTopStackEvent(),
        PriorityStateChange(player: state.priorityPlayer)
      ];
    } else {
      return NextPhaseStateChanges.generate(state);
    }
  }

  @override
  List<Object> get props => [];
}
