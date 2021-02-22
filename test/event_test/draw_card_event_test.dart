import 'package:test/test.dart';
import 'package:hexal_engine/models/card.dart';
import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/cards/00_token/000_test_card.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/events/draw_cards_event.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/state_changes/game_over_state_change.dart';
import 'package:hexal_engine/state_changes/move_card_state_change.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Draw card event', () {
    test('returns the correct move card state change. ', () {
      const card = TestCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.deck,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          DrawCardsEvent(player: Player.one, draws: 1),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(
          changes,
          contains(
              MoveCardStateChange(card: card.id, location: Location.hand)));
    });

    test('can draw multiple cards sequentially. ', () {
      const card1 = TestCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.deck,
      );
      const card2 = TestCard(
        id: 3,
        controller: Player.one,
        owner: Player.one,
        location: Location.deck,
      );
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card1, card2],
        stack: [
          DrawCardsEvent(player: Player.one, draws: 2),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      // Both players pass both draws
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());

      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());

      expect(state.cards, <Card>[
        card1.copyWith(location: Location.hand),
        card2.copyWith(location: Location.hand),
      ]);
    });

    test('returns a game over state change if the deck is empty.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [DrawCardsEvent(player: Player.one, draws: 1)],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(
          changes,
          contains(const GameOverStateChange(
              gameOverState: GameOverState.player2Win)));
    });
  });
}
