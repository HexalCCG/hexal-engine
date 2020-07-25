import 'package:hexal_engine/cards/sample/000_test_card.dart';
import 'package:hexal_engine/event/on_card_enter_field_event.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/state_change/remove_stack_event_state_change.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  group('On card enter field event ', () {
    const p1 = PlayerObject(id: 0, name: 'Alice');
    const p2 = PlayerObject(id: 1, name: 'Bob');
    test(
        'removes itself with no state changes if the card has no relevent effect. ',
        () {
      const card = TestCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        enteredFieldThisTurn: false,
        location: Location.hand,
      );
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          OnCardEnterFieldEvent(card: card),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(
          changes,
          contains(RemoveStackEventStateChange(
              event: OnCardEnterFieldEvent(card: card))));
    });
  });
}
