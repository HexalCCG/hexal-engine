import 'package:hexal_engine/model/state_change/phase_state_change.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/engine/engine.dart';
import 'package:hexal_engine/model/actions/pass_action.dart';
import 'package:hexal_engine/model/game_info.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/objects/card_object.dart';
import 'package:hexal_engine/model/objects/player_object.dart';
import 'package:hexal_engine/model/state_change/priority_state_change.dart';
import 'package:hexal_engine/model/turn_phase.dart';

void main() {
  group('Phase state change', () {
    const p1 = PlayerObject(name: 'Alice');
    const p2 = PlayerObject(name: 'Bob');
    test('changes from . ', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        cards: <CardObject>[],
        stack: <CardObject>[],
        activePlayer: p1,
        priorityPlayer: p1,
        turnPhase: TurnPhase.start,
      );
      const action = PassAction();
      final change = Engine.processAction(state, action);

      expect(change, const [PriorityStateChange(player: p2)]);
    });

    test('moves phase on when used by the non-priority player. ', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        cards: <CardObject>[],
        stack: <CardObject>[],
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.start,
      );
      const action = PassAction();
      final change = Engine.processAction(state, action);

      expect(change, const [
        PhaseStateChange(phase: TurnPhase.draw),
        PriorityStateChange(player: p1),
      ]);
    });
  });
}
