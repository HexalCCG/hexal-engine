import '../events/event.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// StateChange to add an event to the stack.
class AddEventStateChange extends StateChange {
  /// Event to add.
  final Event event;

  /// Adds [event] to the stack.
  const AddEventStateChange({required this.event});

  @override
  GameState apply(GameState state) {
    final idEvent = event.copyWith(id: state.nextEventId);
    return state.copyWith(
        stack: [...state.stack, idEvent], nextEventId: state.nextEventId + 1);
  }

  @override
  List<Object> get props => [event];
}
