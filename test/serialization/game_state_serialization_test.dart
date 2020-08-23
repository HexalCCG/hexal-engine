import 'package:test/test.dart';
import 'package:hexal_engine/events/draw_card_event.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/models/player.dart';
import 'package:hexal_engine/models/location.dart';
import 'package:hexal_engine/models/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/turn_phase.dart';

void main() {
  test('Creatures can attack correctly. ', () {
    const state = GameState(
      gameOverState: GameOverState.playing,
      cards: [
        CowCreatureCard(
          id: 2,
          controller: Player.one,
          owner: Player.one,
          location: Location.field,
          enteredFieldThisTurn: false,
          exhausted: false,
          damage: 0,
        )
      ],
      stack: [DrawCardEvent(player: Player.one, draws: 1)],
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.battle,
    );

    print(state.toJson());
  });
}
