import 'package:hexal_engine/event/draw_card_event.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/state_change/add_stack_event_state_change.dart';
import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  const p1 = PlayerObject(name: 'Alice');
  const p2 = PlayerObject(name: 'Bob');
  group('Add stack event state change', () {
    test('adds event to stack', () {
      final event = DrawCardEvent(
        player: p1,
      );
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
      final stateChange = AddStackEventStateChange(event: event);
      expect(
        state.applyStateChanges([stateChange]).stack,
        [event],
      );
    });
  });
}
