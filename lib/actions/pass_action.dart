import '../card/on_trigger.dart';
import '../effects/targeted_effect.dart';
import '../exceptions/action_exception.dart';
import '../models/game_state.dart';
import '../state_changes/next_phase_state_change.dart';
import '../state_changes/priority_state_change.dart';
import '../state_changes/provide_target_state_change.dart';
import '../state_changes/state_change.dart';
import 'action.dart';

/// Pass the current action. Contains logic for changing turn phase and moving to the next turn.
class PassAction extends Action {
  /// Pass the current action. Contains logic for changing turn phase and moving to the next turn.
  const PassAction();

  @override
  bool valid(GameState state) {
    // If the top stack event is our request
    if (state.stack.isNotEmpty &&
        state.stack.last is TargetedEffect &&
        (state.stack.last as TargetedEffect).target.controller ==
            state.priorityPlayer &&
        !(state.stack.last as TargetedEffect).targetFilled) {
      if (((state.stack.last as TargetedEffect).target.optional ||
          !(state.stack.last as TargetedEffect).target.anyValid(state))) {
        // Allowed to pass if target is optional or no targets are valid
        return true;
      } else {
        // Not allowed to pass required request
        return false;
      }
    }

    // If triggered effects are available
    final effects = state.cards
        .whereType<OnTrigger>()
        .where((card) => card.controller == state.priorityPlayer)
        .map((card) => card.onTriggerEffects)
        .expand((i) => i);

    if (effects.any((effect) => !effect.optional && effect.trigger(state))) {
      // Not allowed to pass non-optional triggered effects.
      return false;
    }

    // All checks passed!!
    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      throw const ActionException(
          'PassAction Exception: Non-optional action pending.');
    }
    // Check if the top event is an unfilled request.
    if (state.stack.isNotEmpty) {
      final _event = state.stack.last;
      if (_event is TargetedEffect &&
          !_event.targetFilled &&
          _event.target.controller == state.priorityPlayer) {
        return _checkRequest(state);
      }
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
      return [const NextPhaseStateChange()];
    }
  }

  List<StateChange> _resolve(GameState state) => state.resolveTopStackEvent();

  List<StateChange> _checkRequest(GameState state) {
    final event = (state.stack.last as TargetedEffect);

    if (event.target.optional || !event.target.anyValid(state)) {
      return [
        const ProvideTargetStateChange(targets: []),
        PriorityStateChange(player: state.notPriorityPlayer),
      ];
    } else {
      throw const ActionException(
          'PassAction Exception: Cannot pass non-optional target request.');
    }
  }

  @override
  List<Object> get props => [];

  /// Create from json.
  static PassAction fromJson(List<dynamic> json) => const PassAction();
}
