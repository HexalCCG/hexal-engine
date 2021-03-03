import '../model/enums/game_over_state.dart';
import '../model/game_state.dart';
import '../state_change/state_change.dart';

/// StateChange to change game over state.
class GameOverStateChange extends StateChange {
  /// New game over state.
  final GameOverState gameOverState;

  /// Sets game over state to [gameOverState].
  const GameOverStateChange({required this.gameOverState});

  @override
  GameState apply(GameState state) {
    return state.copyWith(gameOverState: gameOverState);
  }

  @override
  List<Object> get props => [gameOverState];
}
