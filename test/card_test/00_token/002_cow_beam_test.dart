import 'package:hexal_engine/functions/game_state_test_functions.dart';
import 'package:hexal_engine/models/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/effects/targeted_effect.dart';
import 'package:hexal_engine/actions/provide_target_action.dart';
import 'package:hexal_engine/card/creature.dart';
import 'package:hexal_engine/cards/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/events/on_card_enter_field_event.dart';
import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/actions/play_card_action.dart';
import 'package:hexal_engine/cards/00_token/002_cow_beam_card.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Card test S0.002', () {
    test('enters the field when played.', () {
      const card = CowBeamCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
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
          isA<CowBeamCard>());
      expect(state.priorityPlayer, Player.one);

      // Player 1 keeps priority after playing a card as they are active.
      // They pass, moving priority to player 2.

      state = state.applyAction(const PassAction());
      // Player 2 passes. Top item of stack is resolved.
      state = state.applyAction(const PassAction());

      expect(state.getCardsByLocation(Player.one, Location.field).first,
          isA<CowBeamCard>());
      expect(state.priorityPlayer, Player.one);
    });
    test('correctly deals damage to a target.', () {
      const creature = CowCreatureCard(
        id: 3,
        controller: Player.one,
        owner: Player.one,
        location: Location.field,
        damage: 0,
      );
      const card = CowBeamCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
      );
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [creature, card],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      // Game starts in player 1's main phase 1, and player 1 has priority.
      // Player 1 plays their Cow Beam.
      state = state.applyAction(PlayCardAction(card: card.id));

      // Cow Beam moves into limbo and priority passes.
      expect(state.getCardsByLocation(Player.one, Location.limbo),
          contains(isA<CowBeamCard>()));
      expect(state.priorityPlayer, Player.one);

      // Player 1 keeps priority after playing a card as they are active.
      // They pass, moving priority to player 2.
      state = state.applyAction(const PassAction());
      // Player 2 passes. Top item of stack is resolved.
      state = state.applyAction(const PassAction());

      // Cow Beam moves into the field .
      expect(state.getCardById(2), isA<CowBeamCard>());

      expect(state.stack.last, isA<OnCardEnterFieldEvent>());

      // Player 1 has priority again after the last effect resolved.
      // They pass, moving priority to player 2.
      // Resolves the onenterfield effect creating a damage effect
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      // Resolve the damage effect creating
      // state = state.applyAction(PassAction());
      // state = state.applyAction(PassAction());

      // Cow Beam requests a target for its damage.
      expect(state.stack.last, isA<TargetedEffect>());

      // Player 1 provides a target.
      state = state.applyAction(const ProvideTargetAction(targets: [3]));

      state = GameStateTestFunctions.passUntilEmpty(state);

      expect(
          (state.cards.firstWhere((element) => element.id == 3) as Creature)
              .damage,
          1);
    });
  });
}
