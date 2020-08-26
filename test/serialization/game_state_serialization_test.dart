import 'dart:convert';

import 'package:test/test.dart';
import 'package:hexal_engine/events/draw_card_event.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  test('Serialization works properly. ', () {
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
      //stack: [DrawCardEvent(player: Player.one, draws: 1)],
      stack: [],
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.battle,
    );

    print(json.encode(state));
  });

  test('Deserialization works properly too', () {});
}
