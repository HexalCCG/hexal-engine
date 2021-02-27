import '../events/event.dart';
import '../exceptions/state_change_exception.dart';
import '../models/game_state.dart';
import 'remove_event_state_change.dart';
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
      throw (const StateChangeException('Event not found in stack.'));
    }

    return RemoveEventStateChange(event: event).apply(state);

    // Old resolve pattern
    /*
    final newEvent = state.getEvent(event).copyResolved;
    final newStack = state.stack.replaceSingle(event, newEvent).toList();
    return state.copyWith(stack: newStack);
    */
  }

  @override
  List<Object> get props => [event];
}
