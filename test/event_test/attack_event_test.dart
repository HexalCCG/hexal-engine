import 'package:hexal_engine/actions/attack_action.dart';
import 'package:hexal_engine/event/attack_event.dart';
import 'package:hexal_engine/event/damage_creature_event.dart';
import 'package:hexal_engine/state_change/add_event_state_change.dart';
import 'package:hexal_engine/state_change/put_into_field_state_change.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/cards/sample/002_cow_beam_card.dart';
import 'package:hexal_engine/event/request_target_event.dart';
import 'package:hexal_engine/actions/play_card_action.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/event/on_card_enter_field_event.dart';
import 'package:hexal_engine/cards/sample/000_test_card.dart';
import 'package:hexal_engine/event/play_card_event.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Attack event', () {
    test('deals damage to each creature equal to the other\'s attack. ', () {
      const card1 = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.battlefield,
      );
      const card2 = CowCreatureCard(
        id: 3,
        controller: Player.two,
        owner: Player.two,
        location: Location.battlefield,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card1, card2],
        stack: [
          AttackEvent(attacker: card1, defender: card2),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.battle,
      );
      final changes = state.resolveTopStackEvent();

      expect(
          changes,
          containsAll([
            AddEventStateChange(
                event:
                    DamageCreatureEvent(creature: card1, damage: card2.attack)),
            AddEventStateChange(
                event:
                    DamageCreatureEvent(creature: card2, damage: card1.attack))
          ]));
    });
  });
}
