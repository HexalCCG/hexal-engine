import 'package:hexal_engine/card/creature.dart';
import 'package:hexal_engine/model/history.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/card_data/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/event/draw_cards_event.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';
import 'package:hexal_engine/action/pass_action.dart';
import 'package:hexal_engine/state_change/priority_state_change.dart';

void main() {
  group('Pass action', () {
    test('passes priority when used by the active player. ', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.one,
        turnPhase: TurnPhase.start,
      );
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(change, contains(const PriorityStateChange(player: Player.two)));
    });

    test('moves phase on when used by the non-priority player. ', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.two,
        turnPhase: TurnPhase.start,
      );
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(state.applyStateChanges(change).turnPhase, TurnPhase.draw);
    });
    test('changes active player when used in the end phase.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.two,
        turnPhase: TurnPhase.end,
      );
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(state.applyStateChanges(change).activePlayer, Player.two);
    });
    test('heals all creatures when end phase ends.', () {
      const card = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.field,
        damage: 1,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.two,
        turnPhase: TurnPhase.end,
      );
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(
          (state.applyStateChanges(change).getCardById(2) as Creature).damage,
          0);
    });
    test('adds a draw event to the stack when entering the draw phase.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        history: History.empty(),
        activePlayer: Player.one,
        priorityPlayer: Player.two,
        turnPhase: TurnPhase.start,
      );
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(
        state.applyStateChanges(change).stack,
        contains(const DrawCardsEvent(draws: 1, player: Player.one)),
      );
    });
  });
}
