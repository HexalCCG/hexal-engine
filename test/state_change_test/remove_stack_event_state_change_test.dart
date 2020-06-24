import 'package:hexal_engine/event/draw_card_event.dart';
import 'package:hexal_engine/exceptions/state_change_exception.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/state_change/remove_stack_event_state_change.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  const p1 = PlayerObject(name: 'Alice');
  const p2 = PlayerObject(name: 'Bob');
  group('Remove stack event state change', () {
    test('removes the specified stack event.', () {
      const event = DrawCardEvent(player: Player.one);
      const state = GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [event],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      const change = RemoveStackEventStateChange(event: event);
      expect(
        state.applyStateChanges([change]),
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
    test('throws a state change exception if the event is not found.', () {
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
      const change =
          RemoveStackEventStateChange(event: DrawCardEvent(player: Player.one));
      expect(
        () => state.applyStateChanges([change]),
        throwsA(isA<StateChangeException>()),
      );
    });
  });
}
