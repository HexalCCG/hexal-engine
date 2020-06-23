import 'package:hexal_engine/state_change/modify_entered_field_this_turn_state_change.dart';

import '../../event/draw_card_event.dart';
import '../../game_state/game_state.dart';
import '../../game_state/turn_phase.dart';
import '../active_player_state_change.dart';
import '../add_stack_event_state_change.dart';
import '../phase_state_change.dart';
import '../priority_state_change.dart';
import '../state_change.dart';

class NextPhaseStateChanges {
  static List<StateChange> generate(GameState state) {
    switch (state.turnPhase) {
      case TurnPhase.start:
        // Entering draw phase so add draw a card
        return [
          AddStackEventStateChange(
              event: DrawCardEvent(player: state.activePlayer)),
          PhaseStateChange(phase: TurnPhase.values[state.turnPhase.index + 1]),
          PriorityStateChange(player: state.activePlayer)
        ];
      case TurnPhase.end:
        // Move on to the next turn
        return [
          ActivePlayerStateChange(player: state.notActivePlayer),
          PhaseStateChange(phase: TurnPhase.start),
          PriorityStateChange(player: state.notActivePlayer),
          // Set entered field this turn to false
          ...state.cards.map((card) {
            if (card.enteredFieldThisTurn) {
              return ModifyEnteredFieldThisTurnStateChange(
                  card: card, enteredFieldThisTurn: false);
            } else {
              return null;
            }
          }),
          // TODO heal all creatures
        ];
      default:
        // Move on to the next phase
        return [
          PhaseStateChange(phase: TurnPhase.values[state.turnPhase.index + 1]),
          PriorityStateChange(player: state.activePlayer)
        ];
    }
  }
}
