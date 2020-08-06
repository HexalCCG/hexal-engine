import 'package:test/test.dart';
import 'package:hexal_engine/state_change/end_turn_clear_state_change.dart';
import 'package:hexal_engine/state_change/state_change.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/event/draw_card_event.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/state_change/add_event_state_change.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';
import 'package:hexal_engine/state_change/active_player_state_change.dart';
import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/state_change/phase_state_change.dart';
import 'package:hexal_engine/state_change/priority_state_change.dart';

void main() {
  group('Pass action', () {
    test('passes priority when used by the active player. ', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
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
        activePlayer: Player.one,
        priorityPlayer: Player.two,
        turnPhase: TurnPhase.start,
      );
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(
          change,
          containsAll(const <StateChange>[
            PhaseStateChange(phase: TurnPhase.draw),
            PriorityStateChange(player: Player.one),
          ]));
    });
    test('changes active player when used in the end phase.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.two,
        turnPhase: TurnPhase.end,
      );
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(
          change,
          containsAll(const <StateChange>[
            PhaseStateChange(phase: TurnPhase.start),
            ActivePlayerStateChange(player: Player.two),
            PriorityStateChange(player: Player.two),
          ]));
    });
    test('adds a heal all creatures state change when end phase ends.', () {
      const card = CowCreatureCard(
        id: 2,
        controller: Player.one,
        owner: Player.one,
        location: Location.field,
        enteredFieldThisTurn: false,
        exhausted: false,
        damage: 0,
      );
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [card],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.two,
        turnPhase: TurnPhase.end,
      );
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(
          change,
          contains(
            const EndTurnClearStateChange(card: card),
          ));
    });
    test('adds a draw event to the stack when entering the draw phase.', () {
      final state = const GameState(
        gameOverState: GameOverState.playing,
        cards: [],
        stack: [],
        activePlayer: Player.one,
        priorityPlayer: Player.two,
        turnPhase: TurnPhase.start,
      );
      const action = PassAction();
      final change = state.generateStateChanges(action);

      expect(
          change,
          contains(
            const AddEventStateChange(
                event: DrawCardEvent(draws: 1, player: Player.one)),
          ));
    });
  });
}
