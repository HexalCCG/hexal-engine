import 'package:hexal_engine/models/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';
import 'package:hexal_engine/state_changes/game_over_state_change.dart';

void main() {
  group('Game over state change changes from.', () {
    test('playing to player 1 wins.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      final stateChange =
          const GameOverStateChange(gameOverState: GameOverState.player1Win);
      expect(
        state.applyStateChanges([stateChange]).gameOverState,
        GameOverState.player1Win,
      );
    });
    test('playing to player 2 wins.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      final stateChange =
          const GameOverStateChange(gameOverState: GameOverState.player2Win);
      expect(
        state.applyStateChanges([stateChange]).gameOverState,
        GameOverState.player2Win,
      );
    });
    test('playing to draw.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      final stateChange =
          const GameOverStateChange(gameOverState: GameOverState.draw);
      expect(
        state.applyStateChanges([stateChange]).gameOverState,
        GameOverState.draw,
      );
    });
  });
  test('Game over state change doesn\'t change anything except priority.', () {
    final state = const GameState(
      gameOverState: GameOverState.playing,
      cards: [],
      stack: [],
      history: History.empty(),
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.start,
    );
    final stateChange =
        const GameOverStateChange(gameOverState: GameOverState.draw);
    expect(
      state.applyStateChanges([stateChange]),
      const GameState(
        gameOverState: GameOverState.draw,
        cards: [],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      ),
    );
  });
}
