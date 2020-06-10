import 'package:test/test.dart';

import 'package:hexal_engine/game_state/game_info.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/objects/player_object.dart';

void main() {
  group('GameState creation', () {
    const p1 = PlayerObject(name: 'Alice');
    const p2 = PlayerObject(name: 'Bob');
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
      stack: <CardObject>[],
      activePlayer: p1,
      priorityPlayer: p2,
      turnPhase: TurnPhase.start,
    );
    test('records players.', () {
      expect(state.gameInfo.player1, isNotNull);
      expect(state.gameInfo.player2, isNotNull);
      expect(state.gameInfo.player2, isNot(equals(state.gameInfo.player1)));
    });
    test('records active and priority player.', () {
      expect(state.activePlayer, state.gameInfo.player1);
      expect(state.priorityPlayer, state.gameInfo.player2);
    });
    test('records passed card list.', () {
      expect(state.cards.length, 2);
    });
  });
}
