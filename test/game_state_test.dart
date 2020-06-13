import 'package:hexal_engine/game_state/player.dart';
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
    const card1 = CardObject(
      owner: Player.one,
      controller: Player.one,
      enteredBattlefieldThisTurn: false,
      location: Location.deck,
    );
    const card2 = CardObject(
      owner: Player.two,
      controller: Player.two,
      enteredBattlefieldThisTurn: false,
      location: Location.deck,
    );
    final state = const GameState(
      gameInfo: GameInfo(
        player1: p1,
        player2: p2,
      ),
      gameOverState: GameOverState.playing,
      cards: [card1, card2],
      stack: [],
      activePlayer: Player.one,
      priorityPlayer: Player.two,
      turnPhase: TurnPhase.start,
    );
    test('records players.', () {
      expect(state.gameInfo.player1, isNotNull);
      expect(state.gameInfo.player2, isNotNull);
      expect(state.gameInfo.player2, isNot(equals(state.gameInfo.player1)));
    });
    test('records active and priority player.', () {
      expect(state.activePlayer, Player.one);
      expect(state.priorityPlayer, Player.two);
    });
    test('records passed card list.', () {
      expect(state.cards.length, 2);
    });
  });
}
