import 'package:hexal_engine/model/enums/event_state.dart';
import 'package:hexal_engine/model/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/card_data/00_token/000_test_card.dart';
import 'package:hexal_engine/card_data/00_token/002_cow_beam_card.dart';
import 'package:hexal_engine/event/on_card_enter_field_event.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/state_change/add_event_state_change.dart';
import 'package:hexal_engine/state_change/resolve_event_state_change.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

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
      final state = GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          OnCardEnterFieldEvent(card: card.id),
        ],
        history: const History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(
          changes,
          contains(ResolveEventStateChange(
            event: OnCardEnterFieldEvent(card: card.id),
            eventState: EventState.succeeded,
          )));
    });
    test('adds the card\'s effect if it has only one. ', () {
      const card = CowBeamCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.field,
      );
      final state = GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          OnCardEnterFieldEvent(card: card.id),
        ],
        history: const History.empty(),
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
