import 'package:hexal_engine/action/provide_mana_action.dart';
import 'package:hexal_engine/event/channel_card_event.dart';
import 'package:hexal_engine/event/play_card_event.dart';
import 'package:hexal_engine/event/require_mana_event.dart';
import 'package:hexal_engine/model/history.dart';
import 'package:hexal_engine/model/mana_amount.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/card_data/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

void main() {
  group('Provide mana action test', () {
    test('adds a channel event if valid. ', () {
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [
          CowCreatureCard(
              id: 2,
              owner: Player.one,
              controller: Player.one,
              location: Location.mana,
              damage: 0),
          CowCreatureCard(
              id: 3,
              owner: Player.one,
              controller: Player.one,
              location: Location.limbo,
              damage: 0),
        ],
        stack: [
          PlayCardEvent(card: 3),
          RequireManaEvent(cost: ManaAmount.zero(), card: 3),
        ],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.battle,
      );

      state = state.applyAction(const ProvideManaAction(card: 2));

      expect(state.stack.last, isA<ChannelCardEvent>());
      expect((state.stack.last as ChannelCardEvent).card, 2);
    });
  });
}
