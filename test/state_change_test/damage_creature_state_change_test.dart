import 'package:test/test.dart';
import 'package:hexal_engine/cards/creature.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/state_change/damage_creature_state_change.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Damage creature state change', () {
    test('increases a creature\'s damage by the provided amount', () {
      const creature = CowCreatureCard(
          id: 3,
          owner: Player.one,
          controller: Player.one,
          location: Location.battlefield);
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
