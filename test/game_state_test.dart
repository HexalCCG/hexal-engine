import 'package:test/test.dart';
import 'package:hexal_engine/cards/sample/000_test_card.dart';
import 'package:hexal_engine/state_changes/resolve_event_state_change.dart';
import 'package:hexal_engine/events/draw_card_event.dart';
import 'package:hexal_engine/models/player.dart';
import 'package:hexal_engine/models/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/location.dart';
import 'package:hexal_engine/models/turn_phase.dart';

void main() {
  test('Resolve top stack event returns a resolve stack event state change.',
      () {
    const event = DrawCardEvent(player: Player.one, draws: 1);
    final state = const GameState(
      gameOverState: GameOverState.playing,
      cards: [
        TestCard(
          id: 2,
          controller: Player.one,
          owner: Player.one,
          location: Location.deck,
        )
      ],
      stack: [event],
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.draw,
    );
    final changes = state.resolveTopStackEvent();

    expect(changes, contains(ResolveEventStateChange(event: event)));
  });
}
