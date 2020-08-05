import 'package:hexal_engine/actions/attack_action.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/event/attack_event.dart';
import 'package:hexal_engine/exceptions/action_exception.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/state_change/add_event_state_change.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Attack action test', () {
    test('adds attack event to the stack. ', () {
      const attacker = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.battlefield,
      );
      const defender = CowCreatureCard(
        id: 3,
        controller: Player.two,
        owner: Player.two,
        location: Location.battlefield,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [attacker, defender],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.battle,
      );
      const action = AttackAction(attacker: attacker, defender: defender);
      final change = state.generateStateChanges(action);

      expect(
          change,
          contains(AddEventStateChange(
              event: AttackEvent(attacker: attacker, defender: defender))));
    });
    test('fails if the attacker can\'t attack. ', () {
      const attacker = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.battlefield,
        enteredFieldThisTurn: true,
      );
      const defender = CowCreatureCard(
        id: 3,
        controller: Player.two,
        owner: Player.two,
        location: Location.battlefield,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [attacker, defender],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.battle,
      );
      const action = AttackAction(attacker: attacker, defender: defender);

      expect(() => state.applyAction(action), throwsA(isA<ActionException>()));
    });
  });
}
