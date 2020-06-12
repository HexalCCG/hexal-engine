import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../game_state/player.dart';
import '../state_change/state_change.dart';

class ActivePlayerStateChange extends StateChange {
  final Player player;

  const ActivePlayerStateChange({@required this.player});

  @override
  GameState apply(GameState state) {
    return state.copyWith(activePlayer: player);
  }

  @override
  List<Object> get props => [player];
}
