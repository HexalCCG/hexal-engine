import 'package:hexal_engine/engine/engine.dart';
import 'package:hexal_engine/model/game_info.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/location.dart';
import 'package:hexal_engine/model/objects/card_object.dart';
import 'package:hexal_engine/model/state_change/phase_state_change.dart';
import 'package:hexal_engine/model/turn_phase.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/model/objects/player_object.dart';

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
        cards: <CardObject>[],
        stack: <CardObject>[],
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.start,
      );
      final stateChange = PhaseStateChange(phase: TurnPhase.draw);
      expect(
        Engine.processStateChange(state, [stateChange]).turnPhase,
        TurnPhase.draw,
      );
    });
    test('main phase 1 to battle phase.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        cards: <CardObject>[],
        stack: <CardObject>[],
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.main1,
      );
      final stateChange = PhaseStateChange(phase: TurnPhase.battle);
      expect(
        Engine.processStateChange(state, [stateChange]).turnPhase,
        TurnPhase.battle,
      );
    });
    test('end phase to start phase.', () {
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
      final stateChange = PhaseStateChange(phase: TurnPhase.start);
      expect(
        Engine.processStateChange(state, [stateChange]).turnPhase,
        TurnPhase.start,
      );
    });
    test('draw phase to main phase 2.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        cards: <CardObject>[],
        stack: <CardObject>[],
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.draw,
      );
      final stateChange = PhaseStateChange(phase: TurnPhase.main2);
      expect(
        Engine.processStateChange(state, [stateChange]).turnPhase,
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
        cards: <CardObject>[
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
        stack: <CardObject>[
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
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.start,
      );
      final stateChange = PhaseStateChange(phase: TurnPhase.draw);
      expect(
        Engine.processStateChange(state, [stateChange]),
        const GameState(
          gameInfo: GameInfo(
            player1: p1,
            player2: p2,
          ),
          cards: <CardObject>[
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
          stack: <CardObject>[
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
        cards: <CardObject>[],
        stack: <CardObject>[],
        activePlayer: p1,
        priorityPlayer: p2,
        turnPhase: TurnPhase.start,
      );
      final stateChange = PhaseStateChange(phase: TurnPhase.draw);
      expect(
        Engine.processStateChange(state, [stateChange]).priorityPlayer,
        p2,
      );
    });
  });
}
