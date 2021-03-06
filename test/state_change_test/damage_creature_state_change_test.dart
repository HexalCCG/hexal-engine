import 'package:hexal_engine/model/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/card/creature.dart';
import 'package:hexal_engine/card_data/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/state_change/damage_creature_state_change.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

void main() {
  group('Damage creature state change', () {
    test('increases a creature\'s damage by the provided amount', () {
      const creature = CowCreatureCard(
        id: 3,
        owner: Player.one,
        controller: Player.one,
        location: Location.field,
        damage: 0,
      );
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [creature],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      state = state.applyStateChanges(
          [DamageCreatureStateChange(creature: creature.id, damage: 1)]);
      expect((state.cards.first as Creature).damage, 1);
    });
  });
}
