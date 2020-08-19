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
    return state.copyWith(stack: [...state.stack, event]);
  }

  @override
  List<Object> get props => [event];
}
