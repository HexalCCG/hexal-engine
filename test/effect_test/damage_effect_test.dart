import 'package:test/test.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/effect/damage_effect.dart';
import 'package:hexal_engine/effect/target/creature_target.dart';
import 'package:hexal_engine/event/damage_creature_event.dart';
import 'package:hexal_engine/event/request_target_event.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/state_change/add_event_state_change.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Damage effect', () {
    test('requests a target if one hasn\'t been given yet. ', () {
      const effect = DamageEffect(
          controller: Player.one,
          damage: 1,
          target: CreatureTarget(controller: Player.one));
      const state = GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [effect],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(
          changes,
          contains(const AddEventStateChange(
            event: RequestTargetEvent(
                effect: effect, target: CreatureTarget(controller: Player.one)),
          )));
    });

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
      const effect = DamageEffect(
          controller: Player.one,
          damage: 1,
          target: CreatureTarget(controller: Player.one),
          targetResult: CreatureTargetResult(target: card));
      const state = GameState(
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
          contains(const AddEventStateChange(
            event: DamageCreatureEvent(creature: card, damage: 1),
          )));
    });
  });
}
