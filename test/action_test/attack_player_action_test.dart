import 'package:hexal_engine/models/game_object_reference.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/actions/attack_player_action.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/events/attack_player_event.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/state_changes/add_event_state_change.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Attack player action test', () {
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
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [attacker],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.battle,
      );
      final action = AttackPlayerAction(
          attacker: attacker.toReference,
          player: GameObjectReference(id: Player.two.index));
      final change = state.generateStateChanges(action);

      expect(
          change,
          contains(AddEventStateChange(
              event: AttackPlayerEvent(
                  attacker: attacker.toReference,
                  player: GameObjectReference(id: Player.two.index)))));
    });
  });
}
