import 'package:hexal_engine/game_state/player.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/player_object.dart';
import 'package:hexal_engine/state_change/phase_state_change.dart';

void main() {
  const p1 = PlayerObject(name: 'Alice');
  const p2 = PlayerObject(name: 'Bob');
  test('Phase state change changes phase.', () {
    final state = const GameState(
      gameInfo: GameInfo(
        player1: p1,
        player2: p2,
      ),
      gameOverState: GameOverState.playing,
      cards: [],
      stack: [],
      activePlayer: Player.one,
      priorityPlayer: Player.two,
      turnPhase: TurnPhase.start,
    );
    final stateChange = PhaseStateChange(phase: TurnPhase.draw);
    expect(
      state.applyStateChanges([stateChange]).turnPhase,
      TurnPhase.draw,
    );
  });
  test(
      'Phase state change doesn\'t change activePlayer when moving from end to start phase.',
      () {
    final state = const GameState(
      gameInfo: GameInfo(
        player1: p1,
        player2: p2,
      ),
      gameOverState: GameOverState.playing,
      cards: [],
      stack: [],
      activePlayer: Player.one,
      priorityPlayer: Player.two,
      turnPhase: TurnPhase.start,
    );
    final stateChange = PhaseStateChange(phase: TurnPhase.draw);
    expect(
      state.applyStateChanges([stateChange]).priorityPlayer,
      Player.two,
    );
  });
}
