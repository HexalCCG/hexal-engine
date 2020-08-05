import 'package:hexal_engine/objects/game_object.dart';
import 'package:hexal_engine/state_change/fill_request_state_change.dart';
import 'package:meta/meta.dart';

import '../event/request_target_event.dart';
import '../exceptions/action_exception.dart';
import '../game_state/game_state.dart';
import '../state_change/state_change.dart';
import 'action.dart';

/// Provides target to a request.
class ProvideTargetAction extends Action {
  final List<GameObject> targets;

  const ProvideTargetAction({required this.targets});

  @override
  bool valid(GameState state) {
    if (state.stack.isEmpty || !(state.stack.last is RequestTargetEvent)) {
      // Top event is not a request.
      return false;
    }
    if ((state.stack.last as RequestTargetEvent).target.controller !=
        state.priorityPlayer) {
      // Request is not yours.
      return false;
    }
    if (!(state.stack.last as RequestTargetEvent).target.targetValid(targets)) {
      // Target is not valid.
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
      FillRequestStateChange(
          request: (state.stack.last as RequestTargetEvent),
          targetResult: (state.stack.last as RequestTargetEvent)
              .createTargetResult(targets))
    ];
  }

  @override
  List<Object> get props => [targets];
}
