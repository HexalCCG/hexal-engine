import '../events/event.dart';
import '../exceptions/state_change_exception.dart';
import '../extensions/list_replace.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// StateChange to modify an event.
class ModifyEventStateChange extends StateChange {
  /// Event to replace.
  final Event event;

  /// New event to insert.
  final Event newEvent;

  /// Replaces [event] in the stack with [newEvent].
  const ModifyEventStateChange({required this.event, required this.newEvent});

  @override
  GameState apply(GameState state) {
    if (!state.stack.contains(event)) {
      throw (StateChangeException('Event not found in stack.'));
    }

    final newStack = state.stack.replaceSingle(event, newEvent);
    return state.copyWith(stack: newStack);
  }

  @override
  List<Object> get props => [event, newEvent];
}
