import 'package:hexal_engine/action/activate_triggered_effect_action.dart';
import 'package:hexal_engine/action/pass_action.dart';
import 'package:hexal_engine/action/provide_mana_action.dart';
import 'package:hexal_engine/card_data/01_basic/000_hivequeen_ngaat.dart';
import 'package:hexal_engine/card_data/01_basic/003_awakened_vines.dart';
import 'package:hexal_engine/functions/game_state_test_functions.dart';
import 'package:hexal_engine/model/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/action/play_card_action.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

void main() {
  group('Card test [01.000]', () {
    test('enters the field when mana cost is filled.', () {
      var state = const GameState(
        gameOverState: GameOverState.playing,
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
        cards: [
          AwakenedVines(
            id: 2,
            owner: Player.one,
            controller: Player.one,
            location: Location.mana,
            damage: 0,
          ),
          AwakenedVines(
            id: 3,
            owner: Player.one,
            controller: Player.one,
            location: Location.mana,
            damage: 0,
          ),
          AwakenedVines(
            id: 4,
            owner: Player.one,
            controller: Player.one,
            location: Location.mana,
            damage: 0,
          ),
          AwakenedVines(
            id: 5,
            owner: Player.one,
            controller: Player.one,
            location: Location.mana,
            damage: 0,
          ),
          HivequeenNgaat(
            id: 6,
            owner: Player.one,
            controller: Player.one,
            location: Location.hand,
          ),
        ],
        stack: [],
      );

      state = state.applyAction(const PlayCardAction(card: 6));
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());

      // Provide four earth mana
      state = state.applyAction(const ProvideManaAction(card: 5));
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const ProvideManaAction(card: 4));
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const ProvideManaAction(card: 3));
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const ProvideManaAction(card: 2));
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      // All mana provided so we can resolve RequireManaEvent
      // STACK: [PlayCardEvent, RequireManaEvent]
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      // STACK: [PlayCardEvent:doneRequestMana]
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      // STACK: [PlayCardEvent, CastCardEvent]

      state = GameStateTestFunctions.passUntilEmpty(state);
      expect(state.getCardById(6).location, Location.field);
    });
    test('is exiled if mana cost is failed.', () {
      var state = const GameState(
        gameOverState: GameOverState.playing,
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
        cards: [
          AwakenedVines(
            id: 2,
            owner: Player.one,
            controller: Player.one,
            location: Location.mana,
            damage: 0,
          ),
          AwakenedVines(
            id: 3,
            owner: Player.one,
            controller: Player.one,
            location: Location.mana,
            damage: 0,
          ),
          AwakenedVines(
            id: 4,
            owner: Player.one,
            controller: Player.one,
            location: Location.mana,
            damage: 0,
          ),
          AwakenedVines(
            id: 5,
            owner: Player.one,
            controller: Player.one,
            location: Location.mana,
            damage: 0,
          ),
          HivequeenNgaat(
            id: 6,
            owner: Player.one,
            controller: Player.one,
            location: Location.hand,
          ),
        ],
        stack: [],
      );

      state = state.applyAction(const PlayCardAction(card: 6));
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());

      // Provide three earth mana
      state = state.applyAction(const ProvideManaAction(card: 5));
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const ProvideManaAction(card: 4));
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const ProvideManaAction(card: 3));
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      // All mana provided so we can resolve RequireManaEvent
      // STACK: [PlayCardEvent, RequireManaEvent]
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      // STACK: [PlayCardEvent:doneRequestMana]
      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());
      // STACK: [PlayCardEvent, CastCardEvent]

      state = GameStateTestFunctions.passUntilEmpty(state);
      expect(state.getCardById(6).location, Location.exile);
    });
    test('does nothing if the opponent summons an Earth creature.', () {
      var state = const GameState(
        gameOverState: GameOverState.playing,
        history: History.empty(),
        activePlayer: Player.two,
        priorityPlayer: Player.two,
        turnPhase: TurnPhase.main1,
        cards: [
          AwakenedVines(
            id: 2,
            owner: Player.two,
            controller: Player.two,
            location: Location.hand,
            damage: 0,
          ),
          AwakenedVines(
            id: 3,
            owner: Player.one,
            controller: Player.one,
            location: Location.deck,
            damage: 0,
          ),
          HivequeenNgaat(
            id: 4,
            owner: Player.one,
            controller: Player.one,
            location: Location.field,
          ),
        ],
        stack: [],
      );

      state = state.applyAction(const PlayCardAction(card: 2));

      state = GameStateTestFunctions.passUntilEmpty(state);

      expect(state.getCardById(3).location, Location.deck);
      expect(state.getCardsByLocation(Player.one, Location.hand).length, 0);
    });
    test('draws a card when an Earth creature is summoned.', () {
      var state = const GameState(
        gameOverState: GameOverState.playing,
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.main1,
        cards: [
          AwakenedVines(
            id: 2,
            owner: Player.one,
            controller: Player.one,
            location: Location.hand,
            damage: 0,
          ),
          AwakenedVines(
            id: 3,
            owner: Player.one,
            controller: Player.one,
            location: Location.deck,
            damage: 0,
          ),
          HivequeenNgaat(
            id: 4,
            owner: Player.one,
            controller: Player.one,
            location: Location.field,
          ),
        ],
        stack: [],
      );

      state = state.applyAction(const PlayCardAction(card: 2));

      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());

      state = state.applyAction(const PassAction());
      state = state.applyAction(const PassAction());

      state = state.applyAction(const ActivateTriggeredEffectAction(card: 4));

      state = GameStateTestFunctions.passUntilEmpty(state);

      expect(state.getCardById(3).location, Location.hand);
      expect(state.getCardsByLocation(Player.one, Location.hand).length, 1);
    });
  });
}
