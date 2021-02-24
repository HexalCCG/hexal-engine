import 'package:hexal_engine/models/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/cards/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/events/damage_creature_event.dart';
import 'package:hexal_engine/state_changes/damage_creature_state_change.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Damage creature event', () {
    test('returns a damage creature state change. ', () {
      const card = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.field,
        enteredFieldThisTurn: false,
        exhausted: false,
        damage: 0,
      );
      final state = GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          DamageCreatureEvent(creature: card.id, damage: 1),
        ],
        history: const History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(changes,
          contains(DamageCreatureStateChange(creature: card.id, damage: 1)));
    });
  });
}
