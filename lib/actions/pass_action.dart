import 'package:hexal_engine/effect/target/target.dart';
import 'package:hexal_engine/state_change/fill_request_state_change.dart';
import 'package:hexal_engine/state_change/set_counter_available_state_change.dart';

import '../event/draw_card_event.dart';
import '../event/request_target_event.dart';
import '../exceptions/action_exception.dart';
import '../game_state/game_state.dart';
import '../game_state/turn_phase.dart';
import '../state_change/active_player_state_change.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/end_turn_clear_state_change.dart';
import '../state_change/phase_state_change.dart';
import '../state_change/priority_state_change.dart';
import '../state_change/state_change.dart';
import 'action.dart';

class PassAction extends Action {
  const PassAction();

  @override
  bool valid(GameState state) {
    // If the top stack event is our request
    if (state.stack.isNotEmpty &&
        state.stack.last is RequestTargetEvent &&
        (state.stack.last as RequestTargetEvent).target.controller ==
            state.priorityPlayer) {
      if (((state.stack.last as RequestTargetEvent).target.optional ||
          !(state.stack.last as RequestTargetEvent).target.anyValid(state))) {
        // Allowed to pass if target is optional or no targets are valid
        return true;
      } else {
        // Not allowed to pass required request
        return false;
      }
    }
    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    // Check if the top event is a request.
    if (state.stack.isNotEmpty &&
        state.stack.last is RequestTargetEvent &&
        (state.stack.last as RequestTargetEvent).target.controller ==
            state.priorityPlayer) {
      return _checkRequest(state);
    }

    if (state.priorityPlayer == state.activePlayer) {
      // Active player has passed so check for non-active response.
      return [PriorityStateChange(player: state.notPriorityPlayer)];
    } else if (state.stack.isNotEmpty) {
      // Non-active player has passed so resolve and switch priority.
      return [
        ..._resolve(state),
        PriorityStateChange(player: state.activePlayer)
      ];
    } else {
      return _nextPhase(state);
    }
  }

  List<StateChange> _resolve(GameState state) => state.resolveTopStackEvent();

  List<StateChange> _checkRequest(GameState state) {
    final event = (state.stack.last as RequestTargetEvent);

    if (event.target.optional || !event.target.anyValid(state)) {
      return [
        FillRequestStateChange(
            request: (state.stack.last as RequestTargetEvent),
            targetResult: EmptyTargetResult())
      ];
    } else {
      throw const ActionException(
          'PassAction Exception: Cannot pass non-optional target request.');
    }
  }

  List<StateChange> _nextPhase(GameState state) {
    switch (state.turnPhase) {
      // Entering draw phase so add draw a card
      case TurnPhase.start:
        return [
          AddEventStateChange(
              event: DrawCardEvent(draws: 1, player: state.activePlayer)),
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
          PhaseStateChange(phase: TurnPhase.values[state.turnPhase.index + 1]),
          PriorityStateChange(player: state.activePlayer),
        ];
      // Move on to the next turn
      case TurnPhase.end:
        return [
          ActivePlayerStateChange(player: state.notActivePlayer),
          PhaseStateChange(phase: TurnPhase.start),
          PriorityStateChange(player: state.notActivePlayer),
          // Clear single-turn card variables
          ...state.cards.map((card) => EndTurnClearStateChange(card: card)),
        ];
    }
  }

  @override
  List<Object> get props => [];
}
