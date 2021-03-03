import 'package:hexal_engine/functions/game_state_test_functions.dart';
import 'package:hexal_engine/model/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/action/attack_action.dart';
import 'package:hexal_engine/action/attack_player_action.dart';
import 'package:hexal_engine/exceptions/action_exception.dart';
import 'package:hexal_engine/card_data/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

void main() {
  test('Creatures can attack correctly. ', () {
    const attacker1 = CowCreatureCard(
      id: 2,
      controller: Player.one,
      owner: Player.one,
      location: Location.field,
      damage: 0,
    );
    const attacker2 = CowCreatureCard(
      id: 3,
      controller: Player.one,
      owner: Player.one,
      location: Location.field,
      damage: 0,
    );
    const defender = CowCreatureCard(
      id: 4,
      controller: Player.two,
      owner: Player.two,
      location: Location.field,
      damage: 0,
    );
    var state = const GameState(
      gameOverState: GameOverState.playing,
      cards: [attacker1, attacker2, defender],
      stack: [],
      history: History.empty(),
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.battle,
    );

    expect(
        () => state.applyAction(
            AttackPlayerAction(attacker: attacker1.id, player: Player.two)),
        throwsA(isA<ActionException>()));

    state = state.applyAction(
        AttackAction(attacker: attacker2.id, defender: defender.id));
    state = GameStateTestFunctions.passUntilEmpty(state);
  });
}
