import 'package:hexal_engine/event/draw_card_event.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/state_change/add_stack_event_state_change.dart';
import 'package:test/test.dart';

import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/state_change/active_player_state_change.dart';
import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/objects/player_object.dart';
import 'package:hexal_engine/state_change/phase_state_change.dart';
import 'package:hexal_engine/state_change/priority_state_change.dart';

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
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(change, contains(const PriorityStateChange(player: Player.two)));
    });

    test('moves phase on when used by the non-priority player. ', () {
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
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(
          change,
          containsAll(const [
            PhaseStateChange(phase: TurnPhase.draw),
            PriorityStateChange(player: Player.one),
          ]));
    });
    test('changes active player when used in the end phase.', () {
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
        turnPhase: TurnPhase.end,
      );
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(
          change,
          containsAll(const [
            PhaseStateChange(phase: TurnPhase.start),
            ActivePlayerStateChange(player: Player.two),
            PriorityStateChange(player: Player.two),
          ]));
    });
    test('adds a draw event to the stack when entering the draw phase.', () {
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
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(
          change,
          contains(
            const AddStackEventStateChange(
                event: DrawCardEvent(player: Player.one)),
          ));
    });
  });
}
