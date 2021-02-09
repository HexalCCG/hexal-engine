import '../effects/targeted_effect.dart';
import '../exceptions/state_change_exception.dart';
import '../extensions/list_replace.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// Fills a target request.
class ProvideTargetStateChange extends StateChange {
  /// Request to fill.
  final TargetedEffect request;

  /// Targets to input.
  final List<int> targets;

  /// Fills a target request.
  const ProvideTargetStateChange(
      {required this.request, required this.targets});

  @override
  GameState apply(GameState state) {
    if (!state.stack.contains(request)) {
      throw (StateChangeException('Event not found in stack.'));
    }

    final newStack =
        state.stack.replaceSingle(request, request.copyFilled(targets));
    return state.copyWith(stack: newStack);
  }

  @override
  List<Object> get props => [request, targets];
}
