import 'package:hexal_engine/models/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/models/card.dart';
import 'package:hexal_engine/state_changes/game_over_state_change.dart';
import 'package:hexal_engine/cards/00_token/000_test_card.dart';
import 'package:hexal_engine/events/damage_player_event.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/state_changes/move_card_state_change.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Damage player event', () {
    test('deals 1 damage and resolves if damage is 1. ', () {
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
          DamagePlayerEvent(player: Player.one, damage: 1),
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
              MoveCardStateChange(card: card.id, location: Location.exile)));
    });
    test('deals 2 damage and resolves when damage is 1. ', () {
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
          DamagePlayerEvent(player: Player.one, damage: 2),
        ],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      // Both players pass for first damage
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      // Both players pass for second damage
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      // Expect player 1 to have exiled two cards from their deck.
      expect(state.cards, <Card>[
        card1.copyWith(location: Location.exile),
        card2.copyWith(location: Location.exile),
      ]);
    });
    test('triggers game over if the player has no cards. ', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [
          DamagePlayerEvent(player: Player.one, damage: 1),
        ],
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
  });
}
