import 'package:hexal_engine/state_change/active_player_state_change.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/engine.dart';
import 'package:hexal_engine/game_info.dart';
import 'package:hexal_engine/game_state.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/objects/player_object.dart';
import 'package:hexal_engine/state_change/phase_state_change.dart';
import 'package:hexal_engine/state_change/priority_state_change.dart';
import 'package:hexal_engine/turn_phase.dart';

void main() {
  group('Pass action', () {
    const p1 = PlayerObject(name: 'Alice');
    const p2 = PlayerObject(name: 'Bob');
    test('passes priority when used by the active player. ', () {
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

      expect(change, unorderedEquals(const [PriorityStateChange(player: p2)]));
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

      expect(
          change,
          unorderedEquals(const [
            PhaseStateChange(phase: TurnPhase.draw),
            PriorityStateChange(player: p1),
          ]));
    });
    test('changes active player when used in the end phase.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        cards: <CardObject>[],
        stack: <CardObject>[],
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.end,
      );
      const action = PassAction();
      final change = Engine.processAction(state, action);

      expect(
          change,
          unorderedEquals(const [
            PhaseStateChange(phase: TurnPhase.start),
            ActivePlayerStateChange(player: p2),
            PriorityStateChange(player: p2),
          ]));
    });
  });
}
