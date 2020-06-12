import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/engine.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  const p1 = PlayerObject(name: 'Alice');
  const p2 = PlayerObject(name: 'Bob');
  group('Move card state change', () {
    test('moves card from deck to hand.', () {
      const card = CardObject(
        owner: p1,
        controller: p1,
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
        activePlayer: p1,
        priorityPlayer: p1,
        turnPhase: TurnPhase.start,
      );
      final stateChange =
          MoveCardStateChange(card: card, location: Location.hand);
      expect(
        Engine.processStateChange(state, [stateChange]),
        const GameState(
          gameInfo: GameInfo(
            player1: p1,
            player2: p2,
          ),
          gameOverState: GameOverState.playing,
          cards: [
            CardObject(
              owner: p1,
              controller: p1,
              location: Location.hand,
              enteredBattlefieldThisTurn: false,
            ),
          ],
          stack: [],
          activePlayer: p1,
          priorityPlayer: p1,
          turnPhase: TurnPhase.start,
        ),
      );
    });
  });
}
