import 'package:hexal_engine/model/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/card_data/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/effect/damage_effect.dart';
import 'package:hexal_engine/effect/target/creature_target.dart';
import 'package:hexal_engine/event/damage_creature_event.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/state_change/add_event_state_change.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

void main() {
  group('Damage effect', () {
    test('deals damage to the target when applied.', () {
      const card = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
        damage: 0,
      );
      final effect = DamageEffect(
          controller: Player.one,
          damage: 1,
          target: const CreatureTarget(controller: Player.one),
          targetFilled: true,
          targets: [card.id]);
      final state = GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [effect],
        history: const History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(
          changes,
          contains(AddEventStateChange(
            event: DamageCreatureEvent(creature: card.id, damage: 1),
          )));
    });
  });
}
