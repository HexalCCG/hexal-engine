import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../objects/player_object.dart';
import 'state_change.dart';

class PriorityStateChange extends StateChange {
  final PlayerObject player;
  const PriorityStateChange({@required this.player});

  @override
  List<Object> get props => [player];

  @override
  GameState apply(GameState state) {
    return state.copyWith(priorityPlayer: player);
  }
}
