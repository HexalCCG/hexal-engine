import 'package:hexal_engine/actions/provide_target_action.dart';
import 'package:hexal_engine/effects/damage_effect.dart';
import 'package:hexal_engine/effects/target/creature_target.dart';
import 'package:hexal_engine/models/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/card_data/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Provide target action test', () {
    test('provides a target to the top target request. ', () {
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [
          CowCreatureCard(
              id: 2,
              owner: Player.two,
              controller: Player.two,
              location: Location.field,
              damage: 0),
        ],
        stack: [
          DamageEffect(
            damage: 1,
            target: CreatureTarget(
              controller: Player.one,
            ),
            controller: Player.one,
          )
        ],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.battle,
      );

      state = state.applyAction(const ProvideTargetAction(targets: [2]));

      expect((state.stack.last as DamageEffect).targetFilled, true);
      expect((state.stack.last as DamageEffect).targets, [2]);
    });
  });
}
