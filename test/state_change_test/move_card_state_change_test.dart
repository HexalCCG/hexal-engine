import 'package:hexal_engine/exceptions/state_change_exception.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  const p1 = PlayerObject(name: 'Alice');
  const p2 = PlayerObject(name: 'Bob');
  group('Move card state change', () {
    test('moves card from deck to hand.', () {
      const card = CardObject(
        owner: Player.one,
        controller: Player.one,
        location: Location.deck,
        enteredBattlefieldThisTurn: false,
      );
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [
          card,
        ],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      final stateChange =
          MoveCardStateChange(card: card, location: Location.hand);
      expect(
        state.applyStateChanges([stateChange]),
        const GameState(
          gameInfo: GameInfo(
            player1: p1,
            player2: p2,
          ),
          gameOverState: GameOverState.playing,
          cards: [
            CardObject(
              owner: Player.one,
              controller: Player.one,
              location: Location.hand,
              enteredBattlefieldThisTurn: false,
            ),
          ],
          stack: [],
          activePlayer: Player.one,
          priorityPlayer: Player.one,
          turnPhase: TurnPhase.start,
        ),
      );
    });
    test('throws a state change exception if the card is not found', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      expect(
          () => state.applyStateChanges([
                MoveCardStateChange(
                    card: CardObject(
                        controller: Player.one,
                        location: Location.deck,
                        enteredBattlefieldThisTurn: false,
                        owner: Player.one),
                    location: Location.hand)
              ]),
          throwsA(isA<StateChangeException>()));
    });
  });
}
