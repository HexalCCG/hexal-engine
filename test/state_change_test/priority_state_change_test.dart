import 'package:hexal_engine/model/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';
import 'package:hexal_engine/state_change/priority_state_change.dart';

void main() {
  group('Priority state change changes from', () {
    test('player 1 to player 2.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      final stateChange = const PriorityStateChange(player: Player.two);
      expect(
        state.applyStateChanges([stateChange]).priorityPlayer,
        Player.two,
      );
    });
    test('player 2 to player 1.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.two,
        turnPhase: TurnPhase.start,
      );
      final stateChange = const PriorityStateChange(player: Player.one);
      expect(
        state.applyStateChanges([stateChange]).priorityPlayer,
        Player.one,
      );
    });
  });
  test('Priority state change doesn\'t change anything except priority.', () {
    final state = const GameState(
      gameOverState: GameOverState.playing,
      cards: [],
      stack: [],
      history: History.empty(),
      activePlayer: Player.one,
      priorityPlayer: Player.two,
      turnPhase: TurnPhase.start,
    );
    final stateChange = const PriorityStateChange(player: Player.one);
    expect(
      state.applyStateChanges([stateChange]),
      const GameState(
        gameOverState: GameOverState.playing,
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
