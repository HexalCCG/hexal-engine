import '../effect/targeted_effect.dart';
import '../exceptions/state_change_exception.dart';
import '../model/game_state.dart';
import 'state_change.dart';

/// Fills a target request.
class ProvideTargetStateChange extends StateChange {
  /// Targets to input.
  final List<int> targets;

  /// Fills a target request.
  const ProvideTargetStateChange({required this.targets});

  @override
  GameState apply(GameState state) {
    final request = state.stack.last;
    if (state.stack.last is! TargetedEffect) {
      throw (const StateChangeException('Event not found in stack.'));
    }

    final newStack = [
      ...state.stack.take(state.stack.length - 1),
      (request as TargetedEffect).copyFilled(targets)
    ];

    return state.copyWith(stack: newStack);
  }

  @override
  List<Object> get props => [targets];
}
