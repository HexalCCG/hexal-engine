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
  const string =
      // ignore: lines_longer_than_80_chars
      '{"activePlayer":0,"priorityPlayer":0,"turnPhase":3,"cards":[{"set":0,"number":1,"data":[2,0,0,3,false,false,0]}],"stack":[{"type":"DrawCardEvent","data":[0,1,0,false]}],"gameOverState":0,"counterAvailable":false}';

  test('Serialization works properly. ', () {
    expect(
      json.encode(state),
      string,
    );
  });

  test('Deserialization works properly.', () {
    final jsonMap = json.decode(string) as Map<String, dynamic>;

    final decodedState = GameState.fromJson(jsonMap);

    expect(decodedState, state);
  });
}
