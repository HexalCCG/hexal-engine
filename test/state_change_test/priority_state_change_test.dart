import 'package:hexal_engine/game_state/player.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';
import 'package:hexal_engine/state_change/priority_state_change.dart';

void main() {
  const p1 = PlayerObject(id: 0, name: 'Alice');
  const p2 = PlayerObject(id: 1, name: 'Bob');
  group('Priority state change changes from', () {
    test('player 1 to player 2.', () {
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
      );
      final stateChange = PriorityStateChange(player: Player.two);
      expect(
        state.applyStateChanges([stateChange]).priorityPlayer,
        Player.two,
      );
    });
    test('player 1 to player 2.', () {
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
      );
      final stateChange = PriorityStateChange(player: Player.two);
      expect(
        state.applyStateChanges([stateChange]).priorityPlayer,
        Player.two,
      );
    });
  });
  test('Priority state change doesn\'t change anything except priority.', () {
    final state = const GameState(
      gameInfo: GameInfo(
        player1: p1,
        player2: p2,
      ),
      gameOverState: GameOverState.playing,
      cards: [],
      stack: [],
      activePlayer: Player.one,
      priorityPlayer: Player.two,
      turnPhase: TurnPhase.start,
    );
    final stateChange = PriorityStateChange(player: Player.one);
    expect(
      state.applyStateChanges([stateChange]),
      const GameState(
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
      ),
    );
  });
}
