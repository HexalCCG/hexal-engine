import 'package:hexal_engine/exceptions/state_change_exception.dart';
import 'package:meta/meta.dart';

import '../event/event.dart';
import '../game_state/game_state.dart';
import 'state_change.dart';

class ResolveEventStateChange extends StateChange {
  final Event event;
  const ResolveEventStateChange({@required this.event});

  @override
  GameState apply(GameState state) {
    final index = state.stack.indexOf(event);
    if (index == -1) {
      throw const StateChangeException(
          'ResolveEventStateChange: Provided event not found in stack');
    } else {
      final newStack = state.stack.toList()
        ..replaceRange(index, index, [event]);
      return state.copyWith(stack: newStack);
    }
  }

  @override
  List<Object> get props => [event];
}
