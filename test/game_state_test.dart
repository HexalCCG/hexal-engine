import 'package:hexal_engine/models/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/cards/00_token/000_test_card.dart';
import 'package:hexal_engine/state_changes/resolve_event_state_change.dart';
import 'package:hexal_engine/events/draw_cards_event.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  test('Resolve top stack event returns a resolve stack event state change.',
      () {
    const event = DrawCardsEvent(player: Player.one, draws: 1);
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
      history: History.empty(),
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.draw,
    );
    final changes = state.resolveTopStackEvent();

    expect(changes.first, isA<ResolveEventStateChange>());
  });
}
