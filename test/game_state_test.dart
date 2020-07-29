import 'package:hexal_engine/cards/sample/000_test_card.dart';
import 'package:hexal_engine/state_change/resolve_event_state_change.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/event/draw_card_event.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  const p1 = PlayerObject(id: 0, name: 'Alice');
  const p2 = PlayerObject(id: 1, name: 'Bob');
  test('Resolve top stack event returns a resolve stack event state change.',
      () {
    const event = DrawCardEvent(player: Player.one, draws: 1);
    final state = const GameState(
      gameInfo: GameInfo(
        player1: p1,
        player2: p2,
      ),
      gameOverState: GameOverState.playing,
      cards: [
        TestCard(
          id: 2,
          controller: Player.one,
          owner: Player.one,
          enteredFieldThisTurn: false,
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
