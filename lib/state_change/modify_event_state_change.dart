import '../event/event.dart';
import '../extensions/list_replace.dart';
import '../game_state/game_state.dart';
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
    assert(state.stack.contains(event));

    final newStack = state.stack.replaceSingle(event, newEvent);
    return state.copyWith(stack: newStack);
  }

  @override
  List<Object> get props => [event, newEvent];
}
