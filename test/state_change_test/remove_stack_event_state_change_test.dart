import 'package:test/test.dart';
import 'package:hexal_engine/event/draw_card_event.dart';
import 'package:hexal_engine/exceptions/state_change_exception.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/state_change/remove_event_state_change.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Remove stack event state change', () {
    test('removes the specified stack event.', () {
      const event = DrawCardEvent(player: Player.one, draws: 1);
      const state = GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [event],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      const change = RemoveEventStateChange(event: event);
      expect(
        state.applyStateChanges([change]),
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
    test('throws a state change exception if the event is not found.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      const change = RemoveEventStateChange(
          event: DrawCardEvent(player: Player.one, draws: 1));
      expect(
        () => state.applyStateChanges([change]),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
