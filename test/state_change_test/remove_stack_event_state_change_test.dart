import 'package:test/test.dart';

import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';
import 'package:hexal_engine/state_change/priority_state_change.dart';

void main() {
  const p1 = PlayerObject(name: 'Alice');
  const p2 = PlayerObject(name: 'Bob');
  group('Remove stack event state change', () {
    test('removes the specified stack event.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: p1,
        priorityPlayer: p1,
        turnPhase: TurnPhase.start,
      );
      final stateChange = PriorityStateChange(player: p2);
      //expect(true, false);

      //TODO: remove stack event state change test
      throw UnimplementedError();
    });
  });
}
