import 'package:meta/meta.dart';

import '../event/request_target_event.dart';
import '../exceptions/action_exception.dart';
import '../game_state/game_state.dart';
import '../state_change/state_change.dart';
import 'action.dart';

class ProvideTargetAction extends Action {
  final dynamic target;

  const ProvideTargetAction({@required this.target});

  @override
  bool valid(GameState state) {
    if (state.stack.isEmpty || !(state.stack.last is RequestTargetEvent)) {
      // Top event is not a request.
      return false;
    }
    if ((state.stack.last as RequestTargetEvent).targetResult != null ||
        (state.stack.last as RequestTargetEvent).target.controller !=
            state.priorityPlayer) {
      // Request is not yours or has been filled already.
      return false;
    }
    if (!(state.stack.last as RequestTargetEvent).target.targetValid(target)) {
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
      ...(state.stack.last as RequestTargetEvent).createFillStateChange(target),
    ];
  }

  @override
  List<Object> get props => [target];
}
