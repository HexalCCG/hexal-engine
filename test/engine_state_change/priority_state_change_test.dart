import 'package:hexal_engine/engine/engine.dart';
import 'package:hexal_engine/model/game_info.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/location.dart';
import 'package:hexal_engine/model/objects/card_object.dart';
import 'package:hexal_engine/model/state_change/priority_state_change.dart';
import 'package:hexal_engine/model/turn_phase.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/model/objects/player_object.dart';

void main() {
  const p1 = PlayerObject(name: 'Alice');
  const p2 = PlayerObject(name: 'Bob');
  group('Priority state change changes from', () {
    test('player 1 to player 2.', () {
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
      final stateChange = PriorityStateChange(player: p2);
      expect(
        Engine.processStateChange(state, [stateChange]).priorityPlayer,
        p2,
      );
    });
    test('player 1 to player 2.', () {
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
      final stateChange = PriorityStateChange(player: p2);
      expect(
        Engine.processStateChange(state, [stateChange]).priorityPlayer,
        p2,
      );
    });
  });
  test('Priority state change doesn\'t change anything except priority', () {
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
    final stateChange = PriorityStateChange(player: p1);
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
            owner: p2,
            controller: p2,
            enteredBattlefieldThisTurn: false,
            location: Location.deck,
          ),
        ],
        activePlayer: p1,
        priorityPlayer: p1,
        turnPhase: TurnPhase.start,
      ),
    );
  });
}
