import 'package:hexal_engine/models/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/actions/attack_action.dart';
import 'package:hexal_engine/cards/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/events/attack_event.dart';
import 'package:hexal_engine/exceptions/action_exception.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/state_changes/add_event_state_change.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Attack action test', () {
    test('adds attack event to the stack. ', () {
      const attacker = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.field,
        enteredFieldThisTurn: false,
        exhausted: false,
        damage: 0,
      );
      const defender = CowCreatureCard(
        id: 3,
        controller: Player.two,
        owner: Player.two,
        location: Location.field,
        enteredFieldThisTurn: false,
        exhausted: false,
        damage: 0,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [attacker, defender],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.battle,
      );
      final action = AttackAction(attacker: attacker.id, defender: defender.id);
      final change = state.generateStateChanges(action);

      expect(
          change,
          contains(AddEventStateChange(
              event:
                  AttackEvent(attacker: attacker.id, defender: defender.id))));
    });
    test('fails if the attacker can\'t attack. ', () {
      const attacker = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.field,
        enteredFieldThisTurn: true,
        exhausted: false,
        damage: 0,
      );
      const defender = CowCreatureCard(
        id: 3,
        controller: Player.two,
        owner: Player.two,
        location: Location.field,
        enteredFieldThisTurn: false,
        exhausted: false,
        damage: 0,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [attacker, defender],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.battle,
      );
      final action = AttackAction(attacker: attacker.id, defender: defender.id);

      expect(() => state.applyAction(action), throwsA(isA<ActionException>()));
    });
  });
}
