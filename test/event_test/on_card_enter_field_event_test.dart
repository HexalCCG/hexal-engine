import 'package:test/test.dart';
import 'package:hexal_engine/cards/sample/000_test_card.dart';
import 'package:hexal_engine/cards/sample/002_cow_beam_card.dart';
import 'package:hexal_engine/events/on_card_enter_field_event.dart';
import 'package:hexal_engine/models/player.dart';
import 'package:hexal_engine/state_changes/add_event_state_change.dart';
import 'package:hexal_engine/state_changes/resolve_event_state_change.dart';
import 'package:hexal_engine/models/location.dart';
import 'package:hexal_engine/models/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/turn_phase.dart';

void main() {
  group('On card enter field event ', () {
    test('resolves with no state changes if the card has no relevent effect. ',
        () {
      const card = TestCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          OnCardEnterFieldEvent(card: card),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(
          changes,
          contains(ResolveEventStateChange(
              event: OnCardEnterFieldEvent(card: card))));
    });
    test('adds the card\'s effect if it has only one. ', () {
      const card = CowBeamCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          OnCardEnterFieldEvent(card: card),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(changes,
          contains(AddEventStateChange(event: card.onEnterFieldEffects.first)));
    });
  });
}
