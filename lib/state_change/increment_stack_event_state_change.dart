import 'package:hexal_engine/event/i_incrementing.dart';
import 'package:meta/meta.dart';

import '../event/event.dart';
import '../exceptions/state_change_exception.dart';
import '../game_state/game_state.dart';
import 'state_change.dart';

class IncrementStackEventStateChange extends StateChange {
  final Event event;

  const IncrementStackEventStateChange({@required this.event});

  @override
  GameState apply(GameState state) {
    final newStack = state.stack.toList();
    if (!(event is IIncrementing)) {
      throw const StateChangeException(
          'IncrementStackEventStateChange: Provided event cannot be incremented');
    } else if (!newStack.remove(event)) {
      throw const StateChangeException(
          'IncrementStackEventStateChange: Provided event not found in stack');
    } else {
      newStack.add((event as IIncrementing).increment);
      return state.copyWith(stack: newStack);
    }
  }

  @override
  List<Object> get props => [event];
}
