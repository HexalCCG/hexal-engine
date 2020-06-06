import 'package:hexal_engine/engine/engine.dart';
import 'package:hexal_engine/model/actions/action.dart';
import 'package:hexal_engine/model/actions/pass_action.dart';
import 'package:hexal_engine/model/game_info.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/objects/card_object.dart';
import 'package:hexal_engine/model/objects/player_object.dart';
import 'package:hexal_engine/model/turn_phase.dart';
import 'package:test/test.dart';

void main() {
  group('GameState creation', () {
    test('records players.', () {
      var p1 = PlayerObject();
      var p2 = PlayerObject();
      var state = GameState(
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
      expect(state.gameInfo.player1, p1);
      expect(state.gameInfo.player2, p2);
    });
    test('records active and priority player.', () {
      var p1 = PlayerObject();
      var p2 = PlayerObject();
      var state = GameState(
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
      expect(state.activePlayer, p1);
      expect(state.priorityPlayer, p2);
    });
  });
}
