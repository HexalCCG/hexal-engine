import 'package:hexal_engine/event/draw_card_event.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/state_change/add_event_state_change.dart';
import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  const p1 = PlayerObject(id: 0, name: 'Alice');
  const p2 = PlayerObject(id: 1, name: 'Bob');
  test('Add stack event state change adds event to stack.', () {
    final event = DrawCardEvent(player: Player.one, draws: 1);
    final state = const GameState(
      gameInfo: GameInfo(
        player1: p1,
        player2: p2,
      ),
      gameOverState: GameOverState.playing,
      cards: [],
      stack: [],
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.start,
    );
    final stateChange = AddEventStateChange(event: event);
    expect(
      state.applyStateChanges([stateChange]).stack,
      [event],
    );
  });
}
