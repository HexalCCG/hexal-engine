import 'package:hexal_engine/game_over_state.dart';
import 'package:hexal_engine/location.dart';
import 'package:hexal_engine/state_change/active_player_state_change.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/engine.dart';
import 'package:hexal_engine/game_info.dart';
import 'package:hexal_engine/game_state.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/objects/player_object.dart';
import 'package:hexal_engine/turn_phase.dart';

void main() {
  const p1 = PlayerObject(name: 'Alice');
  const p2 = PlayerObject(name: 'Bob');
  group('Active player state change changes from', () {
    test('player 1 to player 2.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: <CardObject>[],
        stack: <CardObject>[],
        activePlayer: p1,
        priorityPlayer: p1,
        turnPhase: TurnPhase.start,
      );
      final stateChange = ActivePlayerStateChange(player: p2);
      expect(
        Engine.processStateChange(state, [stateChange]).activePlayer,
        p2,
      );
    });
    test('player 1 to player 2.', () {
      final state = const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
        cards: <CardObject>[],
        stack: <CardObject>[],
        activePlayer: p1,
        priorityPlayer: p1,
        turnPhase: TurnPhase.start,
      );
      final stateChange = ActivePlayerStateChange(player: p2);
      expect(
        Engine.processStateChange(state, [stateChange]).activePlayer,
        p2,
      );
    });
  });
  test('Active player state change doesn\'t change anything except priority',
      () {
    final state = const GameState(
      gameInfo: GameInfo(
        player1: p1,
        player2: p2,
      ),
      gameOverState: GameOverState.playing,
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
    );
    final stateChange = ActivePlayerStateChange(player: p2);
    expect(
      Engine.processStateChange(state, [stateChange]),
      const GameState(
        gameInfo: GameInfo(
          player1: p1,
          player2: p2,
        ),
        gameOverState: GameOverState.playing,
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
        activePlayer: p2,
        priorityPlayer: p1,
        turnPhase: TurnPhase.start,
      ),
    );
  });
}
