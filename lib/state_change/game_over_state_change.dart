import 'package:hexal_engine/game_over_state.dart';
import 'package:meta/meta.dart';
import '../game_state.dart';
import '../state_change/state_change.dart';

class GameOverStateChange extends StateChange {
  final GameOverState gameOverState;

  const GameOverStateChange({@required this.gameOverState});

  @override
  GameState apply(GameState state) {
    return state.copyWith(gameOverState: gameOverState);
  }

  @override
  List<Object> get props => [gameOverState];
}
