import 'package:hexal_engine/model/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/action/attack_player_action.dart';
import 'package:hexal_engine/card_data/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/event/attack_player_event.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/state_change/add_event_state_change.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

void main() {
  group('Attack player action test', () {
    test('adds attack event to the stack. ', () {
      const attacker = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.field,
        damage: 0,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [attacker],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.battle,
      );
      final action =
          AttackPlayerAction(attacker: attacker.id, player: Player.two);
      final change = state.generateStateChanges(action);

      expect(
          change,
          contains(AddEventStateChange(
              event: AttackPlayerEvent(
                  attacker: attacker.id, player: Player.two))));
    });
  });
}
