import 'package:test/test.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/events/destroy_card_event.dart';
import 'package:hexal_engine/models/player.dart';
import 'package:hexal_engine/models/location.dart';
import 'package:hexal_engine/models/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/turn_phase.dart';

void main() {
  group('Destroy card event', () {
    test('sends the card from the field to its controller\'s mana.', () {
      const card = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.field,
        enteredFieldThisTurn: false,
        exhausted: false,
        damage: 0,
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
            location: Location.mana,
            enteredFieldThisTurn: false,
            exhausted: false,
            damage: 0,
          ));
    });
  });
}
