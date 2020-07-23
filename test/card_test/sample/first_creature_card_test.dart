import 'package:hexal_engine/actions/play_card_action.dart';
import 'package:hexal_engine/cards/sample/first_creature_card.dart';
import 'package:hexal_engine/event/damage_player_event.dart';
import 'package:hexal_engine/event/play_card_event.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/state_change/game_over_state_change.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  group('First creature card ', () {
    const p1 = PlayerObject(name: 'Alice');
    const p2 = PlayerObject(name: 'Bob');
    test('enters the battlefield when played.', () {
      const card = FirstCreatureCard(
        controller: Player.one,
        owner: Player.one,
        enteredFieldThisTurn: false,
        location: Location.hand,
        damage: 0,
      );
      var state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      state = state.applyActionStateChanges(PlayCardAction(card: card));
      print(state);
      //final changes = state.resolveTopStackEvent();

      //print(changes);
    });
  });
}
