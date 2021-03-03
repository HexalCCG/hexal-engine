import '../card/on_trigger.dart';
import '../effect/targeted_effect.dart';
import '../exceptions/action_exception.dart';
import '../model/enums/event_state.dart';
import '../model/game_state.dart';
import '../state_change/next_phase_state_change.dart';
import '../state_change/priority_state_change.dart';
import '../state_change/provide_target_state_change.dart';
import '../state_change/state_change.dart';
import 'action.dart';

/// Pass the current action. Contains logic for changing turn phase and moving to the next turn.
class PassAction extends Action {
  /// Pass the current action. Contains logic for changing turn phase and moving to the next turn.
  const PassAction();

  @override
  void validate(GameState state) {
    // If the top stack event is our request
    // And it's not been filled already
    if (state.stack.isNotEmpty && state.stack.last is TargetedEffect) {
      final _event = state.stack.last as TargetedEffect;

      if ( // If event belongs to us
          _event.target.controller == state.priorityPlayer &&
              // And has not resolved
              _event.state == EventState.unresolved &&
              // And is not filled already
              !_event.targetFilled &&
              // And is not optional
              !_event.target.optional &&
              // And has valid targets
              _event.target.anyValid(state)) {
        throw const ActionException(
            'PassAction: Could not pass filling non-optional target request.');
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
      throw const ActionException(
          'PassAction: Could not pass non-optional triggered effect.');
    }
  }

  @override
  List<StateChange> apply(GameState state) {
    validate(state);

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

  /// Whether this action can be auto passed.
  static bool canAutoPass(GameState state) {
    // Only allow auto pass if passing is valid.
    // (Shouldn't be necessary as we check all other actions but just in case!)
    if (!const PassAction().valid(state)) {
      return false;
    }

    // Don't allow auto pass to skip phases.
    if (state.priorityPlayer == state.activePlayer && state.stack.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  List<Object> get props => [];

  /// Create from json.
  static PassAction fromJson(List<dynamic> json) => const PassAction();
}
