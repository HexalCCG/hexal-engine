import 'package:hexal_engine/game_state/player.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/state_change/game_over_state_change.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  const p1 = PlayerObject(name: 'Alice');
  const p2 = PlayerObject(name: 'Bob');
  group('Game over state change changes from', () {
    test('playing to player 1 wins.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
        p1DeckOrder: [],
        p2DeckOrder: [],
      );
      final stateChange =
          GameOverStateChange(gameOverState: GameOverState.player1Win);
      expect(
        state.applyStateChanges([stateChange]).gameOverState,
        GameOverState.player1Win,
      );
    });
    test('playing to player 2 wins.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
        p1DeckOrder: [],
        p2DeckOrder: [],
      );
      final stateChange =
          GameOverStateChange(gameOverState: GameOverState.player2Win);
      expect(
        state.applyStateChanges([stateChange]).gameOverState,
        GameOverState.player2Win,
      );
    });
    test('playing to draw.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
        p1DeckOrder: [],
        p2DeckOrder: [],
      );
      final stateChange =
          GameOverStateChange(gameOverState: GameOverState.draw);
      expect(
        state.applyStateChanges([stateChange]).gameOverState,
        GameOverState.draw,
      );
    });
  });
  test('Game over state change doesn\'t change anything except priority', () {
    final state = const GameState(
      gameInfo: GameInfo(
        player1: p1,
        player2: p2,
      ),
      gameOverState: GameOverState.playing,
      cards: [],
      stack: [],
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.start,
      p1DeckOrder: [],
      p2DeckOrder: [],
    );
    final stateChange = GameOverStateChange(gameOverState: GameOverState.draw);
    expect(
      state.applyStateChanges([stateChange]),
      const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.draw,
        cards: [],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
        p1DeckOrder: [],
        p2DeckOrder: [],
      ),
    );
  });
}
