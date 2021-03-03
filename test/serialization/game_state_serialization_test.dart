import 'dart:convert';

import 'package:hexal_engine/models/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/events/draw_cards_event.dart';
import 'package:hexal_engine/card_data/00_token/001_cow_creature_card.dart';
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
        damage: 0,
      )
    ],
    stack: [DrawCardsEvent(player: Player.one, draws: 1)],
    history: History.empty(),
    activePlayer: Player.one,
    priorityPlayer: Player.one,
    turnPhase: TurnPhase.battle,
  );

  test('Game state preserved through serialisation. ', () {
    final result = GameState.fromJson(
        json.decode(json.encode(state)) as Map<String, dynamic>);
    expect(result, state);
  });
}
