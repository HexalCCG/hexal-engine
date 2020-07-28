import 'package:meta/meta.dart';

import '../event/event.dart';
import '../game_state/game_state.dart';
import 'state_change.dart';

class AddEventStateChange extends StateChange {
  final Event event;

  const AddEventStateChange({@required this.event});

  @override
  GameState apply(GameState state) {
    return state.copyWith(stack: state.stack.toList()..add(event));
  }

  @override
  List<Object> get props => [event];
}
