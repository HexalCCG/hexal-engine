import 'package:meta/meta.dart';

import '../event/event.dart';
import '../exceptions/state_change_exception.dart';
import '../game_state/game_state.dart';
import 'state_change.dart';
import '../extensions/list_replace.dart';

class ModifyEventStateChange extends StateChange {
  final Event event;
  final Event newEvent;

  const ModifyEventStateChange({@required this.event, @required this.newEvent});

  @override
  GameState apply(GameState state) {
    if (!state.stack.contains(event)) {
      throw const StateChangeException(
          'ModifyEventStateChange: Provided event not found in stack');
    } else {
      final newStack = state.stack.replaceSingle(event, newEvent);
      return state.copyWith(stack: newStack);
    }
  }

  @override
  List<Object> get props => [event, newEvent];
}
