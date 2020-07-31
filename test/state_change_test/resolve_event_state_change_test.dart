import 'package:hexal_engine/state_change/resolve_event_state_change.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/event/draw_card_event.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/state_change/add_event_state_change.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Resolve event state change', () {
    test('modifies the event to be resolved.', () {
      const event = DrawCardEvent(player: Player.one, draws: 1);
      const resolvedEvent =
          DrawCardEvent(player: Player.one, draws: 1, resolved: true);
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
