import 'package:hexal_engine/event/on_card_enter_field_event.dart';
import 'package:hexal_engine/state_change/add_event_state_change.dart';
import 'package:hexal_engine/state_change/modify_entered_field_this_turn_state_change.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/cards/sample/000_test_card.dart';
import 'package:hexal_engine/event/play_card_event.dart';
import 'package:hexal_engine/game_state/player.dart';
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

      expect(
          changes,
          containsAll([
            MoveCardStateChange(
              card: card,
              location: Location.battlefield,
            ),
            ModifyEnteredFieldThisTurnStateChange(
              card: card,
              enteredFieldThisTurn: true,
            ),
            AddEventStateChange(event: OnCardEnterFieldEvent(card: card)),
          ]));
    });
  });
}
