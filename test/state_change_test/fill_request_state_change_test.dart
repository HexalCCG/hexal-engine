import 'package:test/test.dart';
import 'package:hexal_engine/effect/damage_effect.dart';
import 'package:hexal_engine/effect/target/creature_target.dart';
import 'package:hexal_engine/effect/target/target.dart';
import 'package:hexal_engine/event/request_target_event.dart';
import 'package:hexal_engine/state_change/fill_request_state_change.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Fill request state change', () {
    test('fills the top stack event.', () {
      const target = CreatureTarget(optional: true, controller: Player.one);
      const effect =
          DamageEffect(controller: Player.one, damage: 1, target: target);
      const request = RequestTargetEvent(
        effect: effect,
        target: target,
      );
      var state = GameState(
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
        cards: [],
        stack: [effect, request],
      );
      state = state.applyStateChanges([
        FillRequestStateChange(
            request: request, targetResult: const EmptyTargetResult())
      ]);
      expect((state.stack.last as RequestTargetEvent).targetResult,
          const EmptyTargetResult());
    });
  });
}
