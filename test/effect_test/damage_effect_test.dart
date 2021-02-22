import 'package:test/test.dart';
import 'package:hexal_engine/cards/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/effects/damage_effect.dart';
import 'package:hexal_engine/effects/target/creature_target.dart';
import 'package:hexal_engine/events/damage_creature_event.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/state_changes/add_event_state_change.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Damage effect', () {
    test('deals damage to the target when applied.', () {
      const card = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
        enteredFieldThisTurn: false,
        exhausted: false,
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
