import 'package:hexal_engine/model/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/action/attack_action.dart';
import 'package:hexal_engine/card_data/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/event/attack_event.dart';
import 'package:hexal_engine/exceptions/action_exception.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/state_change/add_event_state_change.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

void main() {
  group('Attack action test', () {
    test('adds attack event to the stack. ', () {
      const attacker = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.field,
        damage: 0,
      );
      const defender = CowCreatureCard(
        id: 3,
        controller: Player.two,
        owner: Player.two,
        location: Location.field,
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
        damage: 0,
      );
      const defender = CowCreatureCard(
        id: 3,
        controller: Player.two,
        owner: Player.two,
        location: Location.field,
        damage: 0,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [attacker, defender],
        stack: [],
        history: History(
          attackedThisTurn: {2},
          enteredFieldThisTurn: {},
          triggeredEffects: {},
        ),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.battle,
      );
      final action = AttackAction(attacker: attacker.id, defender: defender.id);

      expect(() => state.applyAction(action), throwsA(isA<ActionException>()));
    });
  });
}
