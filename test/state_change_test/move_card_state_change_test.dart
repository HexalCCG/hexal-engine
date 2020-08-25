import 'package:hexal_engine/exceptions/state_change_exception.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/cards/sample/000_test_card.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/state_changes/move_card_state_change.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Move card state change', () {
    test('moves card from deck to hand.', () {
      const card = TestCard(
        id: 2,
        owner: Player.one,
        controller: Player.one,
        location: Location.deck,
      );
      final state = const GameState(
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
          gameOverState: GameOverState.playing,
          cards: [
            TestCard(
              id: 2,
              owner: Player.one,
              controller: Player.one,
              location: Location.hand,
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
                    card: TestCard(
                        id: 2,
                        controller: Player.one,
                        location: Location.deck,
                        owner: Player.one),
                    location: Location.hand)
              ]),
          throwsA(isA<StateChangeException>()));
    });
  });
}
