import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/effect/damage_effect.dart';
import 'package:hexal_engine/effect/target/creature_target.dart';
import 'package:hexal_engine/event/damage_creature_event.dart';
import 'package:hexal_engine/event/request_target_event.dart';
import 'package:hexal_engine/exceptions/action_exception.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/cards/sample/000_test_card.dart';
import 'package:hexal_engine/event/play_card_event.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/state_change/combination/put_into_field_state_changes.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Request target event', () {
    test('cannot be passed if set to required. ', () {
      const effect = DamageEffect(
          controller: Player.one,
          damage: 1,
          target: CreatureTarget(optional: false));
      var state = GameState(
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
        cards: [],
        stack: [
          RequestTargetEvent(
            effect: effect,
            target: effect.target,
          )
        ],
      );

      expect(() => state.applyAction(PassAction()),
          throwsA(isA<ActionException>()));
    });
    /*test('can be passed if optional. ', () {
      
    });*/
    test('is filled by fill request action. ', () {});
    test('cannot be passed if set to required. ', () {});
  });
}
