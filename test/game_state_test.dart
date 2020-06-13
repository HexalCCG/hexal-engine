import 'package:hexal_engine/event/draw_card_event.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/state_change/remove_stack_event_state_change.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  test('Resolve top stack event returns a remove stack event state change', () {
    const event = DrawCardEvent(player: Player.one);
    final state = const GameState(
      gameInfo: GameInfo(
        player1: PlayerObject(name: 'Alice'),
        player2: PlayerObject(name: 'Bob'),
      ),
      gameOverState: GameOverState.playing,
      cards: [
        CardObject(
          controller: Player.one,
          owner: Player.one,
          enteredBattlefieldThisTurn: false,
          location: Location.deck,
        )
      ],
      stack: [event],
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.draw,
    );
    final changes = state.resolveTopStackEvent();

    expect(changes, contains(RemoveStackEventStateChange(event: event)));
  });
}
