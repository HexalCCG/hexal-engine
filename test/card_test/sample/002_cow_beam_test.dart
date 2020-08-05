import 'package:test/test.dart';
import 'package:hexal_engine/actions/provide_target_action.dart';
import 'package:hexal_engine/cards/creature.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/event/on_card_enter_field_event.dart';
import 'package:hexal_engine/event/request_target_event.dart';
import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/actions/play_card_action.dart';
import 'package:hexal_engine/cards/sample/002_cow_beam_card.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  group('Card test S.002', () {
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
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      // Game starts in player 1's main phase 1, and player 1 has priority. They have one First Creature in hand.
      // Player 1 plays their First Creature.
      state = state.applyAction(PlayCardAction(card: card));

      // First Creature moves into limbo and priority passes.
      expect(state.getCardsByLocation(Player.one, Location.limbo).first,
          isA<CowBeamCard>());
      expect(state.priorityPlayer, Player.one);

      // Player 1 keeps priority after playing a card as they are active.
      // They pass, moving priority to player 2.

      state = state.applyAction(PassAction());
      // Player 2 passes. Top item of stack is resolved.
      state = state.applyAction(PassAction());

      expect(state.getCardsByLocation(Player.one, Location.field).first,
          isA<CowBeamCard>());
      expect(state.priorityPlayer, Player.one);
    });
    test('correctly deals damage to a target.', () {
      const creature = CowCreatureCard(
        id: 3,
        controller: Player.one,
        owner: Player.one,
        enteredFieldThisTurn: false,
        location: Location.field,
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
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      // Game starts in player 1's main phase 1, and player 1 has priority.
      // Player 1 plays their Cow Beam.
      state = state.applyAction(PlayCardAction(card: card));

      // Cow Beam moves into limbo and priority passes.
      expect(state.getCardsByLocation(Player.one, Location.limbo),
          contains(isA<CowBeamCard>()));
      expect(state.priorityPlayer, Player.one);

      // Player 1 keeps priority after playing a card as they are active.
      // They pass, moving priority to player 2.
      state = state.applyAction(PassAction());
      // Player 2 passes. Top item of stack is resolved.
      state = state.applyAction(PassAction());

      // Cow Beam moves into the field and its enter field effect is added to the stack.
      expect(state.getCardsByLocation(Player.one, Location.field),
          contains(isA<CowBeamCard>()));
      expect(state.stack.last, isA<OnCardEnterFieldEvent>());

      // Player 1 has priority again after the last effect resolved.
      // They pass, moving priority to player 2.
      // Resolves the onenterfield effect creating a damage effect
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      // Resolve the damage effect creating
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());

      // Cow Beam requests a target for its damage.
      expect(state.stack.last, isA<RequestTargetEvent>());

      // Player 1 provides a target.
      state = state.applyAction(ProvideTargetAction(
          target: state.cards.firstWhere((element) => element.id == 3)));

      // Target added to target request & folded into DamageEvent.
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      // Resolved target request removed.
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      // DamageEvent creates a damage creature event.
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      // DamageCreature event damages the creature.
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      // DamageCreature is removed.
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      // DamageEffect is removed.
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      // OnCardEnterField is removed.
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      // PlayCard event is removed.
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());

      expect(
          (state.cards.firstWhere((element) => element.id == 3) as Creature)
              .damage,
          1);
    });
  });
}
