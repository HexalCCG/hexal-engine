import 'package:test/test.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/cards/sample/000_test_card.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/event/draw_card_event.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/state_change/game_over_state_change.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

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
          DrawCardEvent(player: Player.one, draws: 1),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(changes,
          contains(MoveCardStateChange(card: card, location: Location.hand)));
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
          DrawCardEvent(player: Player.one, draws: 2),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      // Both players pass both draws
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());

      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());

      expect(state.cards, <CardObject>[
        card1.copyWithBase(location: Location.hand),
        card2.copyWithBase(location: Location.hand),
      ]);
    });

    test('returns a game over state change if the deck is empty.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [DrawCardEvent(player: Player.one, draws: 1)],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(
          changes,
          contains(
              GameOverStateChange(gameOverState: GameOverState.player2Win)));
    });
  });
}
