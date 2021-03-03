import '../event/draw_cards_event.dart';
import '../model/enums/turn_phase.dart';
import '../model/game_state.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/phase_state_change.dart';
import '../state_change/priority_state_change.dart';
import '../state_change/set_counter_available_state_change.dart';
import '../state_change/state_change.dart';
import 'add_event_state_change.dart';
import 'next_turn_state_change.dart';
import 'state_change.dart';

/// Compiled state change to move to the next phase.
class NextPhaseStateChange extends StateChange {
  /// Compiled state change to move to the next phase.
  const NextPhaseStateChange();

  @override
  GameState apply(GameState state) {
    return state.applyStateChanges(_generateStateChanges(state));
  }

  List<StateChange> _generateStateChanges(GameState state) {
    switch (state.turnPhase) {
      // Entering draw phase so add draw a card
      case TurnPhase.start:
        return [
          AddEventStateChange(
              event: DrawCardsEvent(draws: 1, player: state.activePlayer)),
          const PhaseStateChange(phase: TurnPhase.draw),
          PriorityStateChange(player: state.activePlayer),
        ];
      case TurnPhase.draw:
        return [
          const PhaseStateChange(phase: TurnPhase.main1),
          PriorityStateChange(player: state.activePlayer),
        ];
      case TurnPhase.main1:
        return [
          const PhaseStateChange(phase: TurnPhase.battle),
          const SetCounterAvailableStateChange(enabled: false),
          PriorityStateChange(player: state.activePlayer),
        ];
      case TurnPhase.battle:
        return [
          state.counterAvailable
              ? const PhaseStateChange(phase: TurnPhase.counter)
              : const PhaseStateChange(phase: TurnPhase.main2),
          PriorityStateChange(player: state.activePlayer),
        ];
      case TurnPhase.counter:
        return [
          const PhaseStateChange(phase: TurnPhase.main2),
          PriorityStateChange(player: state.activePlayer),
        ];
      case TurnPhase.main2:
        return [
          const PhaseStateChange(phase: TurnPhase.end),
          PriorityStateChange(player: state.activePlayer),
        ];
      // Move on to the next turn
      case TurnPhase.end:
        return [
          const NextTurnStateChange(),
        ];
      default:
        throw FallThroughError();
    }
  }

  @override
  List<Object> get props => [];
}
