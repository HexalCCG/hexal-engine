import 'package:hexal_engine/exceptions/state_change_exception.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/state_changes/modify_event_state_change.dart';
import 'package:hexal_engine/events/draw_cards_event.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Modify event state change', () {
    test('replaces one event with another.', () {
      const event1 = DrawCardsEvent(player: Player.one, draws: 1);
      const event2 = DrawCardsEvent(player: Player.two, draws: 2);
      const state = GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [event1],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      const stateChange =
          ModifyEventStateChange(event: event1, newEvent: event2);
      expect(
        state.applyStateChanges([stateChange]).stack,
        [event2],
      );
    });
    test('throws an exception if the event is not found.', () {
      const event1 = DrawCardsEvent(player: Player.one, draws: 1);
      const missingEvent = DrawCardsEvent(player: Player.two, draws: 0);
      const event2 = DrawCardsEvent(player: Player.two, draws: 2);
      const state = GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [event1],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      const stateChange =
          ModifyEventStateChange(event: missingEvent, newEvent: event2);
      expect(
        () => state.applyStateChanges([stateChange]),
        throwsA(isA<StateChangeException>()),
      );
    });
  });
}
