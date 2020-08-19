import '../effects/target/target.dart';
import '../events/provide_target_event.dart';
import '../events/request_target_event.dart';
import '../extensions/list_replace.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// Fills the provided request with a target result.
class FillRequestStateChange extends StateChange {
  /// Request to replace.
  final RequestTargetEvent request;

  /// Target result to insert.
  final TargetResult targetResult;

  /// Replaces [request] in the stack with a target result provider.
  const FillRequestStateChange(
      {required this.request, required this.targetResult});

  @override
  GameState apply(GameState state) {
    return state.copyWith(
        stack: state.stack.replaceSingle(
            request,
            ProvideTargetEvent(
                effect: request.effect, targetResult: targetResult)));
  }

  @override
  List<Object> get props => [request, targetResult];
}
