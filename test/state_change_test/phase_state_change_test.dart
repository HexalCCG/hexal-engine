import 'package:test/test.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';
import 'package:hexal_engine/state_changes/phase_state_change.dart';

void main() {
  test('Phase state change changes phase.', () {
    final state = const GameState(
      gameOverState: GameOverState.playing,
      cards: [],
      stack: [],
      activePlayer: Player.one,
      priorityPlayer: Player.two,
      turnPhase: TurnPhase.start,
    );
    final stateChange = const PhaseStateChange(phase: TurnPhase.draw);
    expect(
      state.applyStateChanges([stateChange]).turnPhase,
      TurnPhase.draw,
    );
  });
  test('Phase state change doesn\'t change activePlayer.', () {
    final state = const GameState(
      gameOverState: GameOverState.playing,
      cards: [],
      stack: [],
      activePlayer: Player.one,
      priorityPlayer: Player.two,
      turnPhase: TurnPhase.start,
    );
    final stateChange = const PhaseStateChange(phase: TurnPhase.draw);
    expect(
      state.applyStateChanges([stateChange]).priorityPlayer,
      Player.two,
    );
  });
}
