import 'package:test/test.dart';
import 'package:hexal_engine/state_changes/resolve_event_state_change.dart';
import 'package:hexal_engine/events/draw_cards_event.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Resolve event state change', () {
    test('modifies the event to be resolved.', () {
      const event = DrawCardsEvent(player: Player.one, draws: 1);
      const resolvedEvent =
          DrawCardsEvent(player: Player.one, draws: 1, resolved: true);
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [event],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      const stateChange = ResolveEventStateChange(event: event);
      expect(
        state.applyStateChanges([stateChange]).stack,
        [resolvedEvent],
      );
    });
  });
}
