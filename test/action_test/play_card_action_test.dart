import 'package:hexal_engine/actions/play_card_action.dart';
import 'package:hexal_engine/cards/sample/test_card.dart';
import 'package:hexal_engine/event/play_card_event.dart';
import 'package:hexal_engine/exceptions/action_exception.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/state_change/add_stack_event_state_change.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  group('Play card action', () {
    const p1 = PlayerObject(name: 'Alice');
    const p2 = PlayerObject(name: 'Bob');

    test('adds play card event to the stack. ', () {
      const card = TestCard(
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
        enteredFieldThisTurn: false,
      );
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      const action = PlayCardAction(card: card);
      final change = state.generateStateChanges(action);

      expect(
          change,
          containsAll([
            AddStackEventStateChange(
                event: PlayCardEvent(
                    card: card.copyWith({'location': Location.limbo}))),
          ]));
    });
    test('fails if targeting card not in hand', () {
      const card = TestCard(
        controller: Player.one,
        owner: Player.one,
        location: Location.deck,
        enteredFieldThisTurn: false,
      );
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      const action = PlayCardAction(card: card);

      expect(
        () => state.generateStateChanges(action),
        throwsA(isA<ActionException>()),
      );
    });
    test('fails if used by non-active player', () {
      const card = TestCard(
        controller: Player.two,
        owner: Player.two,
        location: Location.hand,
        enteredFieldThisTurn: false,
      );
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.two,
        turnPhase: TurnPhase.main1,
      );
      const action = PlayCardAction(card: card);

      expect(
        () => state.generateStateChanges(action),
        throwsA(isA<ActionException>()),
      );
    });
  });
}
