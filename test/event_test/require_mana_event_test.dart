import 'package:hexal_engine/card_data/00_token/000_test_card.dart';
import 'package:hexal_engine/model/enums/event_state.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/event/require_mana_event.dart';
import 'package:hexal_engine/model/history.dart';
import 'package:hexal_engine/model/mana_amount.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:hexal_engine/state_change/resolve_event_state_change.dart';
import 'package:hexal_engine/event/play_card_event.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

void main() {
  group('Require mana event', () {
    test('resolves without exiling if the cost is paid. ', () {
      const card = TestCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.limbo,
      );
      const state = GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          PlayCardEvent(card: 2),
          RequireManaEvent(
            card: 2,
            cost: ManaAmount(neutral: 1),
            provided: ManaAmount(air: 1),
          ),
        ],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      expect(
          state.resolveTopStackEvent().contains(const ResolveEventStateChange(
                event: RequireManaEvent(
                  card: 2,
                  cost: ManaAmount(neutral: 1),
                  provided: ManaAmount(air: 1),
                ),
                eventState: EventState.succeeded,
              )),
          true);
      expect(
          state.resolveTopStackEvent().contains(
              const MoveCardStateChange(card: 2, location: Location.exile)),
          false);
    });
    test('exiles its card if the cost is not met. ', () {
      const card = TestCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.limbo,
      );
      const state = GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          PlayCardEvent(card: 2),
          RequireManaEvent(
            card: 2,
            cost: ManaAmount(neutral: 1),
            provided: ManaAmount(),
          ),
        ],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      expect(
          state.resolveTopStackEvent().contains(const ResolveEventStateChange(
              event: RequireManaEvent(
                card: 2,
                cost: ManaAmount(neutral: 1),
                provided: ManaAmount(),
              ),
              eventState: EventState.failed)),
          true);
      expect(
          state.resolveTopStackEvent().contains(
              const MoveCardStateChange(card: 2, location: Location.exile)),
          true);
    });
  });
}
