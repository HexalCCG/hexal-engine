import 'package:hexal_engine/models/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/effects/damage_effect.dart';
import 'package:hexal_engine/effects/target/creature_target.dart';
import 'package:hexal_engine/state_changes/provide_target_state_change.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Provide target state change', () {
    test('fills the top stack event.', () {
      const target = CreatureTarget(optional: true, controller: Player.one);
      const effect =
          DamageEffect(controller: Player.one, damage: 1, target: target);
      var state = const GameState(
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
        cards: [],
        stack: [effect],
        history: History.empty(),
      );
      state = state
          .applyStateChanges([const ProvideTargetStateChange(targets: [])]);
      expect((state.stack.last as DamageEffect).targetFilled, true);
      expect((state.stack.last as DamageEffect).targets, isEmpty);
    });
  });
}
