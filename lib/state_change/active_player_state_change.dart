import '../game_state/game_state.dart';
import '../game_state/player.dart';
import '../state_change/state_change.dart';

/// StateChange to change the active player.
class ActivePlayerStateChange extends StateChange {
  /// Player to make active.
  final Player player;

  /// Sets active player to [player].
  const ActivePlayerStateChange({required this.player});

  @override
  GameState apply(GameState state) {
    return state.copyWith(activePlayer: player);
  }

  @override
  List<Object> get props => [player];
}
