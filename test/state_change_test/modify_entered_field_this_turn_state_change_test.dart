import 'package:hexal_engine/cards/sample/test_card.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/exceptions/state_change_exception.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/state_change/modify_entered_field_this_turn_state_change.dart';
import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  const p1 = PlayerObject(name: 'Alice');
  const p2 = PlayerObject(name: 'Bob');
  group('Modify entered field this turn state change', () {
    test('changes entered field this turn.', () {
      const card = TestCard(
        owner: Player.one,
        controller: Player.one,
        location: Location.battlefield,
        enteredFieldThisTurn: false,
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
      final stateChange = ModifyEnteredFieldThisTurnStateChange(
          card: card, enteredFieldThisTurn: true);
      expect(
        state.applyStateChanges([stateChange]),
        const GameState(
          gameInfo: GameInfo(
            player1: p1,
            player2: p2,
          ),
          gameOverState: GameOverState.playing,
          cards: [
            TestCard(
              owner: Player.one,
              controller: Player.one,
              location: Location.battlefield,
              enteredFieldThisTurn: true,
            ),
          ],
          stack: [],
          activePlayer: Player.one,
          priorityPlayer: Player.one,
          turnPhase: TurnPhase.start,
        ),
      );
    });
    test('throws a state change exception if the card is not found.', () {
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
                ModifyEnteredFieldThisTurnStateChange(
                    card: TestCard(
                        controller: Player.one,
                        location: Location.deck,
                        enteredFieldThisTurn: false,
                        owner: Player.one),
                    enteredFieldThisTurn: false)
              ]),
          throwsA(isA<StateChangeException>()));
    });
  });
}
