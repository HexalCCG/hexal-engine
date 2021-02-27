import 'package:hexal_engine/effects/targeted_effect.dart';
import 'package:hexal_engine/events/cast_card_event.dart';
import 'package:hexal_engine/functions/game_state_test_functions.dart';
import 'package:hexal_engine/models/history.dart';
import 'package:hexal_engine/state_changes/add_event_state_change.dart';
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
        history: const History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
      );
      final changes = state.resolveTopStackEvent();

      expect(
          changes,
          contains(
            AddEventStateChange(event: CastCardEvent(card: card.id)),
          ));
    });
    test('does not destroy a played permanent.', () {
      const creature = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.hand,
        damage: 0,
      );
      var state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [creature],
        stack: [],
        history: History.empty(),
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

      expect(state.stack.last, isA<PlayCardEvent>());

      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());

      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());

      expect(state.getCardsByLocation(Player.one, Location.field),
          contains(isA<CowCreatureCard>()));
      expect(state.stack.last, isA<CastCardEvent>());

      // Resolve and remove the play effect
      state = GameStateTestFunctions.passUntilEmpty(state);

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
        history: History.empty(),
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
      state = state.applyAction(const PassAction());
      // Player 2 passes. Top item of stack is resolved.
      state = state.applyAction(const PassAction());

      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());

      // Cow moves into the field.
      expect(state.getCardById(2).location, Location.field);
      expect(state.stack.last, isA<OnCardEnterFieldEvent>());

      state = GameStateTestFunctions.passUntilEmpty(state);

      expect((state.stack), isEmpty);
      expect((state.cards.firstWhere((element) => element.id == 2).location),
          Location.mana);
    });
  });
}
