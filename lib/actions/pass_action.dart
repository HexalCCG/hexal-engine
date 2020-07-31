import 'package:hexal_engine/event/request_target_event.dart';
import 'package:hexal_engine/exceptions/action_exception.dart';

import '../game_state/game_state.dart';
import '../state_change/combination/next_phase_state_changes.dart';
import '../state_change/priority_state_change.dart';
import '../state_change/state_change.dart';
import 'action.dart';

class PassAction extends Action {
  const PassAction();

  @override
  List<StateChange> apply(GameState state) {
    // Check if the top event is a request.
    if (state.stack.isNotEmpty) {
      var topStackEvent = state.stack.last;
      if (topStackEvent is RequestTargetEvent &&
          topStackEvent.targetResult == null &&
          topStackEvent.target.controller == state.priorityPlayer) {
        // Top event is a request that we control.
        if (topStackEvent.targetValid(null)) {
          return [
            ...topStackEvent.createFillStateChange(null),
          ];
        } else {
          throw const ActionException(
              'PassAction Exception: Cannot pass non-optional target request.');
        }
      }
    }

    if (state.priorityPlayer == state.activePlayer) {
      // Active player has passed so check for non-active response
      return [PriorityStateChange(player: state.notPriorityPlayer)];
    } else if (state.stack.isNotEmpty) {
      // Non-active player has passed so resolve top stack event and switch priority
      return [
        ...state.resolveTopStackEvent(),
        PriorityStateChange(player: state.activePlayer)
      ];
    } else {
      return NextPhaseStateChanges.generate(state);
    }
  }

  @override
  List<Object> get props => [];
}
