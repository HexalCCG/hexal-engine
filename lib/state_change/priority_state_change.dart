import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../game_state/player.dart';
import 'state_change.dart';

class PriorityStateChange extends StateChange {
  final Player player;
  const PriorityStateChange({@required this.player});

  @override
  GameState apply(GameState state) {
    return state.copyWith(priorityPlayer: player);
  }

  @override
  List<Object> get props => [player];
}
