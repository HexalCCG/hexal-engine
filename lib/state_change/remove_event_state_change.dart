import '../event/event.dart';
import '../game_state/game_state.dart';
import 'state_change.dart';

/// StateChange to remove an event.
class RemoveEventStateChange extends StateChange {
  /// Event to remove.
  final Event event;

  /// Removes [event] from the stack.
  const RemoveEventStateChange({required this.event});

  @override
  GameState apply(GameState state) {
    assert(state.stack.contains(event));

    final newStack = state.stack.toList()..remove(event);
    return state.copyWith(stack: newStack);
  }

  @override
  List<Object> get props => [event];
}
