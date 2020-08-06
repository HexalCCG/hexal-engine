import 'package:hexal_engine/exceptions/state_change_exception.dart';
import 'package:meta/meta.dart';

import '../event/event.dart';
import '../game_state/game_state.dart';
import 'state_change.dart';
import '../extensions/list_replace.dart';

/// StateChange to resolve an event.
class ResolveEventStateChange extends StateChange {
  /// Event to resolve.
  final Event event;

  /// Sets [event] to resolved.
  const ResolveEventStateChange({required this.event});

  @override
  GameState apply(GameState state) {
    assert(state.stack.contains(event));

    final newEvent = state.getEvent(event).copyResolved;
    final newStack = state.stack.replaceSingle(event, newEvent);
    return state.copyWith(stack: newStack);
  }

  @override
  List<Object> get props => [event];
}
