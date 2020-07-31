import 'package:meta/meta.dart';
import 'package:hexal_engine/event/request_target_event.dart';
import '../exceptions/action_exception.dart';
import '../game_state/game_state.dart';
import '../state_change/state_change.dart';
import 'action.dart';

class ProvideTargetAction extends Action {
  final dynamic target;

  const ProvideTargetAction({@required this.target});

  @override
  List<StateChange> apply(GameState state) {
    // Check if the top event is a request.
    if (state.stack.isNotEmpty) {
      var topStackEvent = state.stack.last;
      if (topStackEvent is RequestTargetEvent &&
          topStackEvent.targetResult == null &&
          topStackEvent.target.controller == state.priorityPlayer) {
        // Top event is a request that we control.
        if (topStackEvent.targetValid(target)) {
          return [
            ...topStackEvent.createFillStateChange(target),
          ];
        } else {
          throw const ActionException(
              'ProvideTargetAction Exception: Cannot pass non-optional target request.');
        }
      } else {
        throw const ActionException(
            ('ProvideTargetAction Exception: Request could not be filled'));
      }
    } else {
      throw const ActionException(
          ('ProvideTargetAction Exception: Top event is not a request'));
    }
  }

  @override
  List<Object> get props => [target];
}
