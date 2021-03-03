import '../model/enums/turn_phase.dart';
import '../model/game_state.dart';
import '../state_change/active_player_state_change.dart';
import '../state_change/clear_all_damage_state_change.dart';
import '../state_change/clear_history_state_change.dart';
import '../state_change/phase_state_change.dart';
import '../state_change/priority_state_change.dart';
import '../state_change/state_change.dart';
import 'state_change.dart';

/// Compiled state change to move to the next turn.
class NextTurnStateChange extends StateChange {
  /// Compiled state change to move to the next turn.
  const NextTurnStateChange();

  @override
  GameState apply(GameState state) {
    return state.applyStateChanges(_generateStateChanges(state));
  }

  List<StateChange> _generateStateChanges(GameState state) {
    return [
      // Toggle the active player and give them priority.
      ActivePlayerStateChange(player: state.notActivePlayer),
      PriorityStateChange(player: state.notActivePlayer),
      // Reset the turn phase.
      const PhaseStateChange(phase: TurnPhase.start),
      // Clear all damage on cards.
      const ClearAllDamageStateChange(),
      // Clear the turn history.
      const ClearHistory(),
    ];
  }

  @override
  List<Object> get props => [];
}
