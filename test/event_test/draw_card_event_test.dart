import 'package:hexal_engine/card_data/01_basic/003_awakened_vines.dart';
import 'package:hexal_engine/functions/game_state_test_functions.dart';
import 'package:hexal_engine/model/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/card/card.dart';
import 'package:hexal_engine/action/pass_action.dart';
import 'package:hexal_engine/card_data/00_token/000_test_card.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/event/draw_cards_event.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/state_change/game_over_state_change.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

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
        history: History.empty(),
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
        history: History.empty(),
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
        history: History.empty(),
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

    test('draws 1 card when given 1 draw.', () {
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [
          AwakenedVines(
              id: 2,
              owner: Player.one,
              controller: Player.one,
              location: Location.deck,
              damage: 0),
          AwakenedVines(
              id: 3,
              owner: Player.one,
              controller: Player.one,
              location: Location.deck,
              damage: 0),
          AwakenedVines(
              id: 4,
              owner: Player.one,
              controller: Player.one,
              location: Location.deck,
              damage: 0),
          AwakenedVines(
              id: 5,
              owner: Player.one,
              controller: Player.one,
              location: Location.deck,
              damage: 0),
        ],
        stack: [DrawCardsEvent(player: Player.one, draws: 1)],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );

      expect(state.getCardsByLocation(Player.one, Location.hand).length, 0);

      state = GameStateTestFunctions.passUntilEmpty(state);

      expect(state.getCardsByLocation(Player.one, Location.hand).length, 1);
    });

    test('draws the last card in a deck without ending the game.', () {
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [
          AwakenedVines(
              id: 2,
              owner: Player.one,
              controller: Player.one,
              location: Location.deck,
              damage: 0),
        ],
        stack: [DrawCardsEvent(player: Player.one, draws: 1)],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );

      expect(state.getCardsByLocation(Player.one, Location.hand).length, 0);

      state = GameStateTestFunctions.passUntilEmpty(state);

      expect(state.getCardsByLocation(Player.one, Location.hand).length, 1);
      expect(state.gameOverState, GameOverState.playing);
    });
  });
}
