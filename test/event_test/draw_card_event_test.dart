import 'package:hexal_engine/cards/sample/000_test_card.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/event/draw_card_event.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/state_change/game_over_state_change.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  group('Draw card event', () {
    const p1 = PlayerObject(name: 'Alice');
    const p2 = PlayerObject(name: 'Bob');
    test('returns the correct move card state change. ', () {
      const card = TestCard(
        controller: Player.one,
        owner: Player.one,
        enteredFieldThisTurn: false,
        location: Location.deck,
      );
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          DrawCardEvent(player: Player.one),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(changes,
          contains(MoveCardStateChange(card: card, location: Location.hand)));
    });

    test('returns a game over state change if the deck is empty.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [DrawCardEvent(player: Player.one)],
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
