import 'package:test/test.dart';
import 'package:hexal_engine/cards/sample/000_test_card.dart';
import 'package:hexal_engine/event/play_card_event.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/state_change/combination/put_into_field_state_changes.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Play card event', () {
    test('returns the correct enter battlefield event. ', () {
      const card = TestCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        enteredFieldThisTurn: false,
        location: Location.limbo,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          PlayCardEvent(card: card),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      final changes = state.resolveTopStackEvent();

      expect(changes, containsAll(PutIntoFieldStateChanges.generate(card)));
    });
  });
}
