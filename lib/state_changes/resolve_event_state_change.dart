import '../events/event.dart';
import '../exceptions/state_change_exception.dart';
import '../extensions/replace_single.dart';
import '../models/enums/event_state.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// StateChange to resolve an event.
class ResolveEventStateChange extends StateChange {
  /// Event to resolve.
  final Event event;

  /// Resolution state to set it to.
  final EventState eventState;

  /// Sets [event] to resolved.
  const ResolveEventStateChange(
      {required this.event, required this.eventState});

  @override
  GameState apply(GameState state) {
    if (!state.stack.contains(event)) {
      throw const StateChangeException('Event not found in stack.');
    }

    if (eventState == EventState.unresolved) {
      throw const StateChangeException('Cannot change event to unresolved.');
    }

    // Removing event.
    //return RemoveEventStateChange(event: event).apply(state);

    final newEvent = state.getEvent(event).copyWith(state: eventState);
    final newStack = state.stack.replaceSingle(event, newEvent).toList();
    return state.copyWith(stack: newStack);
  }

  @override
  List<Object> get props => [event];
}
