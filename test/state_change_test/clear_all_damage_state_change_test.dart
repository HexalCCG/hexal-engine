import 'package:hexal_engine/models/history.dart';
import 'package:hexal_engine/state_changes/clear_all_damage_state_change.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/card_data/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Clear all damage state change ', () {
    test('sets the card\'s damage to 0. ', () {
      const card = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
        damage: 1,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.draw,
      );
      final result = state.applyStateChanges([
        const ClearAllDamageStateChange(),
      ]);

      expect(
          result,
          const GameState(
            gameOverState: GameOverState.playing,
            cards: [
              CowCreatureCard(
                id: 2,
                controller: Player.one,
                owner: Player.one,
                location: Location.hand,
                damage: 0,
              )
            ],
            stack: [],
            history: History.empty(),
            activePlayer: Player.one,
            priorityPlayer: Player.one,
            turnPhase: TurnPhase.draw,
          ));
    });
  });
}
