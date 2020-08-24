import '../events/event.dart';
import '../exceptions/state_change_exception.dart';
import '../extensions/list_replace.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// StateChange to resolve an event.
class ResolveEventStateChange extends StateChange {
  /// Event to resolve.
  final Event event;

  /// Sets [event] to resolved.
  const ResolveEventStateChange({required this.event});

  @override
  GameState apply(GameState state) {
    if (!state.stack.contains(event)) {
      throw (StateChangeException('Event not found in stack.'));
    }

    final newEvent = state.getEvent(event).copyResolved;
    final newStack = state.stack.replaceSingle(event, newEvent);
    return state.copyWith(stack: newStack);
  }

  @override
  List<Object> get props => [event];
}
