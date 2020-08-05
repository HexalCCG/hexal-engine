import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/event/destroy_card_event.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Destroy card event', () {
    test('sends the card from the field to its controller\'s mana.', () {
      const card = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        enteredFieldThisTurn: false,
        location: Location.field,
      );
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          DestroyCardEvent(card: card),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      state = state.applyStateChanges(state.resolveTopStackEvent());

      expect(
          state.cards.last,
          const CowCreatureCard(
            id: 2,
            controller: Player.one,
            owner: Player.one,
            enteredFieldThisTurn: false,
            location: Location.mana,
          ));
    });
  });
}
