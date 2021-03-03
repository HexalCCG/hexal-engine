import 'package:hexal_engine/model/enums/event_state.dart';
import 'package:hexal_engine/model/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/state_change/resolve_event_state_change.dart';
import 'package:hexal_engine/event/draw_cards_event.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

void main() {
  group('Resolve event state change', () {
    test('changes the event to resolved.', () {
      const event = DrawCardsEvent(player: Player.one, draws: 1);
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [event],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      const stateChange =
          ResolveEventStateChange(event: event, eventState: EventState.failed);
      expect(
        state.applyStateChanges([stateChange]).stack.first,
        isA<DrawCardsEvent>(),
      );
      expect(
        state.applyStateChanges([stateChange]).stack.first.state,
        EventState.failed,
      );
    });
  });
}
