import 'package:hexal_engine/exceptions/state_change_exception.dart';
import 'package:meta/meta.dart';

import '../event/event.dart';
import '../game_state/game_state.dart';
import 'state_change.dart';
import '../extensions/list_replace.dart';

class ResolveEventStateChange extends StateChange {
  final Event event;

  const ResolveEventStateChange({@required this.event});

  @override
  GameState apply(GameState state) {
    if (!state.stack.contains(event)) {
      throw const StateChangeException(
          'ResolveEventStateChange: Provided event not found in stack');
    } else {
      final newEvent = state.getEvent(event).copyResolved;
      final newStack = state.stack.replaceSingle(event, newEvent);
      return state.copyWith(stack: newStack);
    }
  }

  @override
  List<Object> get props => [event];
}
