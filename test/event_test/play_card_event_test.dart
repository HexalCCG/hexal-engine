import 'package:hexal_engine/effects/targeted_effect.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/state_changes/state_change.dart';
import 'package:hexal_engine/state_changes/put_into_field_state_change.dart';
import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/cards/00_token/002_cow_beam_card.dart';
import 'package:hexal_engine/actions/play_card_action.dart';
import 'package:hexal_engine/cards/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/events/on_card_enter_field_event.dart';
import 'package:hexal_engine/cards/00_token/000_test_card.dart';
import 'package:hexal_engine/events/play_card_event.dart';
import 'package:hexal_engine/models/enums/player.dart';
import 'package:hexal_engine/models/enums/location.dart';
import 'package:hexal_engine/models/enums/game_over_state.dart';
import 'package:hexal_engine/models/game_state.dart';
import 'package:hexal_engine/models/enums/turn_phase.dart';

void main() {
  group('Play card event', () {
    test('returns the correct enter field event. ', () {
      const card = TestCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.limbo,
      );
      final state = GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [
          PlayCardEvent(card: card.id),
        ],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      final changes = state.resolveTopStackEvent();

      expect(
          changes,
          containsAll(<StateChange>[
            PutIntoFieldStateChange(card: card.id),
          ]));
    });
    test('does not destroy a played permanent.', () {
      const creature = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
        enteredFieldThisTurn: false,
        exhausted: false,
        damage: 0,
      );
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [creature],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      // Game starts in player 1's main phase 1, and player 1 has priority.
      // Player 1 plays their creature.
      state = state.applyAction(PlayCardAction(card: creature.id));

      // Cow moves into limbo and priority passes.
      expect(state.getCardsByLocation(Player.one, Location.limbo),
          contains(isA<CowCreatureCard>()));
      expect(state.priorityPlayer, Player.one);

      // Player 1 keeps priority after playing a card as they are active.
      // They pass, moving priority to player 2.
      state = state.applyAction(PassAction());
      // Player 2 passes. Top item of stack is resolved.
      state = state.applyAction(PassAction());

      // Cow moves into the field.
      expect(state.getCardsByLocation(Player.one, Location.field),
          contains(isA<CowCreatureCard>()));
      expect(state.stack.last, isA<PlayCardEvent>());

      // Resolve and remove the play effect
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());

      expect(state.stack, isEmpty);
      expect(state.getCardsByLocation(Player.one, Location.field),
          contains(isA<CowCreatureCard>()));
    });
    test('destroys a played non-permanent as it resolves.', () {
      const spell = CowBeamCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
      );
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [spell],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      // Game starts in player 1's main phase 1, and player 1 has priority.
      // Player 1 plays their creature.
      state = state.applyAction(PlayCardAction(card: spell.id));

      // Cow moves into limbo and priority passes.
      expect(state.getCardsByLocation(Player.one, Location.limbo),
          contains(isA<CowBeamCard>()));
      expect(state.priorityPlayer, Player.one);

      // Player 1 keeps priority after playing a card as they are active.
      // They pass, moving priority to player 2.
      state = state.applyAction(PassAction());
      // Player 2 passes. Top item of stack is resolved.
      state = state.applyAction(PassAction());

      // Cow moves into the field.
      expect(state.getCardsByLocation(Player.one, Location.field),
          contains(isA<CowBeamCard>()));
      expect(state.stack.last, isA<OnCardEnterFieldEvent>());

      // Player 1 has priority again after the last effect resolved.
      // They pass, moving priority to player 2.
      // Resolves the onenterfield effect
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      // Resolve the play effect
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());

      // Cow Beam requests a target for its damage.
      expect(state.stack.last, isA<TargetedEffect>());
      expect(state.getCardsByLocation(Player.one, Location.field),
          contains(isA<CowBeamCard>()));

      // Player 1 fails to provide a target.
      state = state.applyAction(PassAction());

      // Target added to target request & folded into DamageEvent.
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());

      // DamageEffect resolves with EmptyTargetResult and is removed
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());

      // OnCardEnterField is removed
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());

      // PlayCardEvent destroys spell
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());

      // DestroyCardEvent removed
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());
      // PlayCardEvent removed
      state = state.applyAction(PassAction());
      state = state.applyAction(PassAction());

      expect((state.stack), isEmpty);
      expect((state.cards.firstWhere((element) => element.id == 2).location),
          Location.mana);
    });
  });
}
