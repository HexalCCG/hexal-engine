import 'package:hexal_engine/engine/engine.dart';
import 'package:hexal_engine/model/actions/pass_action.dart';
import 'package:hexal_engine/model/game_info.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/objects/card_object.dart';
import 'package:hexal_engine/model/objects/player_object.dart';
import 'package:hexal_engine/model/turn_phase.dart';
import 'package:test/test.dart';

void main() {
  group('Pass action', () {
    final p1 = PlayerObject();
    final p2 = PlayerObject();
    final startingState = GameState(
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
    test('Pass action ', () {
      final action = PassAction();

      expect(Engine.validate(startingState, PassAction()), true);
    });
  });
}
