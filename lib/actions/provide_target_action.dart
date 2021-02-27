import '../effects/targeted_effect.dart';
import '../exceptions/action_exception.dart';
import '../models/game_state.dart';
import '../state_changes/priority_state_change.dart';
import '../state_changes/provide_target_state_change.dart';
import '../state_changes/state_change.dart';
import 'action.dart';

/// Provides target to a request.
class ProvideTargetAction extends Action {
  /// Targets provided by player.
  final List<int> targets;

  /// Provides targets to a request.
  const ProvideTargetAction({required this.targets});

  @override
  bool valid(GameState state) {
    // Check stack isn't empty.
    if (state.stack.isEmpty || state.stack.last is! TargetedEffect) {
      return false;
    }
    final _request = state.stack.last as TargetedEffect;
    // Request must not be filled.
    if (_request.targetFilled) {
      return false;
    }
    // Check request belongs to the priority player.
    if (_request.target.controller != state.priorityPlayer) {
      return false;
    }
    // Check provided targets are valid.
    if (!(_request.target.targetValid(state, targets))) {
      return false;
    }
    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      throw const ActionException(
          'ProvideTargetAction Exception: invalid argument');
    }

    return [
      ProvideTargetStateChange(
        targets: targets,
      ),
      PriorityStateChange(player: state.activePlayer),
    ];
  }

  @override
  List<Object> get props => [targets];

  /// Create from json.
  static ProvideTargetAction fromJson(List<dynamic> json) =>
      ProvideTargetAction(
        targets:
            (json[0] as List<dynamic>).map((dynamic id) => id as int).toList(),
      );
}
