import 'package:test/test.dart';
import 'package:hexal_engine/models/player.dart';
import 'package:hexal_engine/models/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/turn_phase.dart';
import 'package:hexal_engine/state_changes/priority_state_change.dart';

void main() {
  group('Priority state change changes from', () {
    test('player 1 to player 2.', () {
      final state = const GameState(
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
