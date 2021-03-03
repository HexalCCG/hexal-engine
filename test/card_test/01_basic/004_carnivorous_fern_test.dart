import 'package:hexal_engine/card_data/01_basic/004_carnivorous_fern.dart';
import 'package:hexal_engine/functions/game_state_test_functions.dart';
import 'package:hexal_engine/models/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/actions/play_card_action.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Card test [01.004]', () {
    test('enters the field when played.', () {
      const card = CarnivorousFern(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
        damage: 0,
      );
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      // Game starts in player 1's main phase 1, and player 1 has priority.
      // They have one First Creature in hand.
      // Player 1 plays their First Creature.
      state = state.applyAction(PlayCardAction(card: card.id));

      // First Creature moves into limbo and priority passes.
      expect(state.getCardsByLocation(Player.one, Location.limbo).first,
          isA<CarnivorousFern>());
      expect(state.priorityPlayer, Player.one);

      // Player 1 keeps priority after playing a card as they are active.
      // They pass, moving priority to player 2.

      state = GameStateTestFunctions.passUntilEmpty(state);

      expect(state.getCardsByLocation(Player.one, Location.field).first,
          isA<CarnivorousFern>());
      expect(state.priorityPlayer, Player.one);
    });
    test('can attack creatures but not players.', () {
      const card = CarnivorousFern(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
        damage: 0,
      );
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      // Game starts in player 1's main phase 1, and player 1 has priority.
      // They have one First Creature in hand.
      // Player 1 plays their First Creature.
      state = state.applyAction(PlayCardAction(card: card.id));

      // Player 1 keeps priority after playing a card as they are active.
      // They pass, moving priority to player 2.

      state = GameStateTestFunctions.passUntilEmpty(state);

      // Check creature can attack creatures but not players.
      expect(
          (state.getCardsByLocation(Player.one, Location.field).first
                  as CarnivorousFern)
              .canAttack(state),
          true);
      expect(
          (state.getCardsByLocation(Player.one, Location.field).first
                  as CarnivorousFern)
              .canAttackPlayer(state),
          false);
    });
  });
}
