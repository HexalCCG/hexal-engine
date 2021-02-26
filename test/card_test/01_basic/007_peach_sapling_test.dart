import 'package:hexal_engine/cards/01_basic/007_peach_sapling.dart';
import 'package:hexal_engine/events/draw_cards_event.dart';
import 'package:hexal_engine/models/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/actions/play_card_action.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Card test S1.007', () {
    test('draws a card when played.', () {
      const card = PeachSapling(
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
          isA<PeachSapling>());
      expect(state.priorityPlayer, Player.one);

      // Player 1 keeps priority after playing a card as they are active.
      // They pass, moving priority to player 2.

      state = state.applyAction(const PassAction());
      // Player 2 passes. Top item of stack is resolved.
      state = state.applyAction(const PassAction());

      expect(state.getCardsByLocation(Player.one, Location.field).first,
          isA<PeachSapling>());
      expect(state.priorityPlayer, Player.one);

      // Card entered field so it should add draw card to stack.
      state = state.applyAction(const PassAction());
      // Player 2 passes. Top item of stack is resolved.
      state = state.applyAction(const PassAction());

      // Resolve draw cards effect adding draw cards event to stack.
      state = state.applyAction(const PassAction());
      // Player 2 passes. Top item of stack is resolved.
      state = state.applyAction(const PassAction());

      expect(state.stack.last, isA<DrawCardsEvent>());
      expect((state.stack.last as DrawCardsEvent).draws, 1);
    });
  });
}
