import 'package:test/test.dart';
import 'package:hexal_engine/actions/play_card_action.dart';
import 'package:hexal_engine/cards/sample/000_test_card.dart';
import 'package:hexal_engine/event/play_card_event.dart';
import 'package:hexal_engine/exceptions/action_exception.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/state_change/add_event_state_change.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Play card action', () {
    test('adds play card event to the stack. ', () {
      const card = TestCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
      );
      final state = const GameState(
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
            AddEventStateChange(
                event: PlayCardEvent(
                    card: card.copyWith({'location': Location.limbo}))),
          ]));
    });
    test('fails if targeting card not in hand', () {
      const card = TestCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.deck,
      );
      final state = const GameState(
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
        id: 2,
        controller: Player.two,
        owner: Player.two,
        location: Location.hand,
      );
      final state = const GameState(
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
