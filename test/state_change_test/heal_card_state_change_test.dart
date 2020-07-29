import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';
import 'package:hexal_engine/state_change/heal_card_state_change.dart';
import 'package:test/test.dart';

void main() {
  group('Heal card state change ', () {
    const p1 = PlayerObject(id: 0, name: 'Alice');
    const p2 = PlayerObject(id: 1, name: 'Bob');
    test('sets the card\'s damage to 0. ', () {
      const card = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        enteredFieldThisTurn: false,
        location: Location.hand,
        damage: 1,
      );
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final result = state.applyStateChanges([
        HealCardStateChange(card: card),
      ]);

      expect(
          result,
          const GameState(
            gameInfo: GameInfo(
              player1: p1,
              player2: p2,
            ),
            gameOverState: GameOverState.playing,
            cards: [
              CowCreatureCard(
                id: 2,
                controller: Player.one,
                owner: Player.one,
                enteredFieldThisTurn: false,
                location: Location.hand,
                damage: 0,
              )
            ],
            stack: [],
            activePlayer: Player.one,
            priorityPlayer: Player.one,
            turnPhase: TurnPhase.draw,
          ));
    });
  });
}
