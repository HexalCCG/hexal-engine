import 'package:hexal_engine/models/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/cards/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/events/destroy_card_event.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Destroy card event', () {
    test('sends the card from the field to its controller\'s mana.', () {
      const card = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.field,
        damage: 0,
      );
      var state = GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          DestroyCardEvent(card: card.id),
        ],
        history: const History.empty(),
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
            damage: 0,
          ));
    });
  });
}
