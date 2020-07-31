import 'package:test/test.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/event/damage_creature_event.dart';
import 'package:hexal_engine/state_change/damage_creature_state_change.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Damage creature event', () {
    test('returns a damage creature state change. ', () {
      const card = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        enteredFieldThisTurn: false,
        location: Location.deck,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          DamageCreatureEvent(card: card, damage: 1),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final changes = state.resolveTopStackEvent();

      expect(
          changes, contains(DamageCreatureStateChange(card: card, damage: 1)));
    });
  });
}
