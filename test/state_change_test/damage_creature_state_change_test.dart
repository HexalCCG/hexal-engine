import 'package:test/test.dart';
import 'package:hexal_engine/cards/creature.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/models/location.dart';
import 'package:hexal_engine/state_changes/damage_creature_state_change.dart';
import 'package:hexal_engine/models/player.dart';
import 'package:hexal_engine/models/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/turn_phase.dart';

void main() {
  group('Damage creature state change', () {
    test('increases a creature\'s damage by the provided amount', () {
      const creature = CowCreatureCard(
        id: 3,
        owner: Player.one,
        controller: Player.one,
        location: Location.field,
        enteredFieldThisTurn: false,
        exhausted: false,
        damage: 0,
      );
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [creature],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      state = state.applyStateChanges(
          [DamageCreatureStateChange(creature: creature, damage: 1)]);
      expect((state.cards.first as Creature).damage, 1);
    });
  });
}
