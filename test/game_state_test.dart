import 'package:hexal_engine/model/game_info.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/location.dart';
import 'package:hexal_engine/model/objects/card_object.dart';
import 'package:hexal_engine/model/objects/player_object.dart';
import 'package:hexal_engine/model/turn_phase.dart';
import 'package:test/test.dart';

void main() {
  group('GameState creation', () {
    final p1 = PlayerObject();
    final p2 = PlayerObject();
    final state = GameState(
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
