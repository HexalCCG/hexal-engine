import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/actions/play_card_action.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  group('Card test S.002 ', () {
    const p1 = PlayerObject(name: 'Alice');
    const p2 = PlayerObject(name: 'Bob');
    test('enters the battlefield when played.', () {
      const card = CowCreatureCard(
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
      // Game starts in player 1's main phase 1, and player 1 has priority. They have one First Creature in hand.
      // Player 1 plays their First Creature.
      state = state.applyAction(PlayCardAction(card: card));

      // First Creature moves into limbo and priority passes.
      expect(state.getCardsByLocation(Player.one, Location.limbo).first,
          isA<CowCreatureCard>());
      expect(state.priorityPlayer, Player.two);

      // Player 2 passes. Priority passes.
      state = state.applyAction(PassAction());
      // Player 1 passes. Played card is resolved.
      state = state.applyAction(PassAction());

      expect(state.getCardsByLocation(Player.one, Location.battlefield).first,
          isA<CowCreatureCard>());
      expect(state.priorityPlayer, Player.one);
    });
  });
}
