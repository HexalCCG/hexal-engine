import '../events/event.dart';
import '../exceptions/state_change_exception.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// StateChange to remove an event.
class RemoveEventStateChange extends StateChange {
  /// Event to remove.
  final Event event;

  /// Removes [event] from the stack.
  const RemoveEventStateChange({required this.event});

  @override
  GameState apply(GameState state) {
    if (!state.stack.contains(event)) {
      throw (StateChangeException('Event not found in stack.'));
    }

    final newStack = state.stack.toList()..remove(event);
    return state.copyWith(stack: newStack);
  }

  @override
  List<Object> get props => [event];
}
