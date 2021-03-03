import 'package:hexal_engine/card_data/00_token/000_test_card.dart';
import 'package:hexal_engine/event/channel_card_event.dart';
import 'package:hexal_engine/event/require_mana_event.dart';
import 'package:hexal_engine/model/enums/event_state.dart';
import 'package:hexal_engine/model/history.dart';
import 'package:hexal_engine/model/mana_amount.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:hexal_engine/state_change/resolve_event_state_change.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

void main() {
  group('Channel card event', () {
    test('fizzles if card is not in mana.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [
          TestCard(
            id: 2,
            controller: Player.one,
            owner: Player.one,
            location: Location.field,
          ),
          TestCard(
            id: 3,
            controller: Player.one,
            owner: Player.one,
            location: Location.limbo,
          ),
        ],
        stack: [
          RequireManaEvent(cost: ManaAmount.zero(), card: 3),
          ChannelCardEvent(card: 2, controller: Player.one, targetCard: 3),
        ],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );

      final changes = state.resolveTopStackEvent();

      expect(changes, const [
        ResolveEventStateChange(
          event:
              ChannelCardEvent(card: 2, controller: Player.one, targetCard: 3),
          eventState: EventState.failed,
        )
      ]);
    });
    test('fizzles if card is controlled by opponent.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [
          TestCard(
            id: 2,
            controller: Player.two,
            owner: Player.one,
            location: Location.mana,
          ),
          TestCard(
            id: 3,
            controller: Player.one,
            owner: Player.one,
            location: Location.limbo,
          ),
        ],
        stack: [
          RequireManaEvent(cost: ManaAmount.zero(), card: 3),
          ChannelCardEvent(card: 2, controller: Player.one, targetCard: 3),
        ],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );

      final changes = state.resolveTopStackEvent();

      expect(changes, const [
        ResolveEventStateChange(
            event: ChannelCardEvent(
                card: 2, controller: Player.one, targetCard: 3),
            eventState: EventState.failed)
      ]);
    });
    test('exiles channel card if situation is valid.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [
          TestCard(
            id: 2,
            controller: Player.one,
            owner: Player.one,
            location: Location.mana,
          ),
          TestCard(
            id: 3,
            controller: Player.one,
            owner: Player.one,
            location: Location.limbo,
          ),
        ],
        stack: [
          RequireManaEvent(cost: ManaAmount.zero(), card: 3),
          ChannelCardEvent(card: 2, controller: Player.one, targetCard: 3),
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
          const MoveCardStateChange(card: 2, location: Location.exile),
        ),
      );
    });
  });
}
