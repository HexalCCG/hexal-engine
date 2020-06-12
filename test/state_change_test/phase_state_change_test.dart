import 'package:test/test.dart';

import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/objects/player_object.dart';
import 'package:hexal_engine/state_change/phase_state_change.dart';

void main() {
  const p1 = PlayerObject(name: 'Alice');
  const p2 = PlayerObject(name: 'Bob');
  group('Phase state change changes from', () {
    test('start phase to draw phase.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.start,
      );
      final stateChange = PhaseStateChange(phase: TurnPhase.draw);
      expect(
        state.applyStateChanges([stateChange]).turnPhase,
        TurnPhase.draw,
      );
    });
    test('main phase 1 to battle phase.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.main1,
      );
      final stateChange = PhaseStateChange(phase: TurnPhase.battle);
      expect(
        state.applyStateChanges([stateChange]).turnPhase,
        TurnPhase.battle,
      );
    });
    test('end phase to start phase.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.end,
      );
      final stateChange = PhaseStateChange(phase: TurnPhase.start);
      expect(
        state.applyStateChanges([stateChange]).turnPhase,
        TurnPhase.start,
      );
    });
    test('draw phase to main phase 2.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.draw,
      );
      final stateChange = PhaseStateChange(phase: TurnPhase.main2);
      expect(
        state.applyStateChanges([stateChange]).turnPhase,
        TurnPhase.main2,
      );
    });
  });
  group('Phase state change doesn\'t change', () {
    test('anything except phase.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [
          CardObject(
            owner: p1,
            controller: p1,
            enteredBattlefieldThisTurn: false,
            location: Location.deck,
          ),
          CardObject(
            owner: p2,
            controller: p2,
            enteredBattlefieldThisTurn: false,
            location: Location.deck,
          ),
        ],
        stack: [],
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.start,
      );
      final stateChange = PhaseStateChange(phase: TurnPhase.draw);
      expect(
        state.applyStateChanges([stateChange]),
        const GameState(
          gameInfo: GameInfo(
            player1: p1,
            player2: p2,
          ),
          gameOverState: GameOverState.playing,
          cards: [
            CardObject(
              owner: p1,
              controller: p1,
              enteredBattlefieldThisTurn: false,
              location: Location.deck,
            ),
            CardObject(
              owner: p2,
              controller: p2,
              enteredBattlefieldThisTurn: false,
              location: Location.deck,
            ),
          ],
          stack: [],
          activePlayer: p1,
          priorityPlayer: p2,
          turnPhase: TurnPhase.draw,
        ),
      );
    });
    test('activePlayer when moving from end to start phase.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.start,
      );
      final stateChange = PhaseStateChange(phase: TurnPhase.draw);
      expect(
        state.applyStateChanges([stateChange]).priorityPlayer,
        p2,
      );
    });
  });
}
