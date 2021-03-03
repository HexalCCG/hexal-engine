import 'package:hexal_engine/action/provide_mana_action.dart';
import 'package:hexal_engine/event/channel_card_event.dart';
import 'package:hexal_engine/event/require_mana_event.dart';
import 'package:hexal_engine/functions/game_state_test_functions.dart';
import 'package:test/test.dart';
import 'package:hexal_engine/action/pass_action.dart';
import 'package:hexal_engine/action/play_card_action.dart';
import 'package:hexal_engine/card_data/00_token/003_expensive_cow.dart';
import 'package:hexal_engine/model/history.dart';
import 'package:hexal_engine/card_data/00_token/001_cow_creature_card.dart';
import 'package:hexal_engine/model/enums/player.dart';
import 'package:hexal_engine/model/enums/location.dart';
import 'package:hexal_engine/model/enums/game_over_state.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/enums/turn_phase.dart';

void main() {
  test('Summoning creatures with costs works.', () {
    var state = const GameState(
      gameOverState: GameOverState.playing,
      cards: [
        CowCreatureCard(
          id: 2,
          controller: Player.one,
          owner: Player.one,
          location: Location.mana,
          damage: 0,
        ),
        ExpensiveCowCard(
          id: 3,
          owner: Player.one,
          controller: Player.one,
          location: Location.hand,
          damage: 0,
        ),
      ],
      stack: [],
      history: History.empty(),
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.main1,
    );

    state = state.applyAction(const PlayCardAction(card: 3));

    // Both players pass to do first pass of play card action
    state = state.applyAction(const PassAction());
    state = state.applyAction(const PassAction());

    expect(state.stack.last, isA<RequireManaEvent>());

    state = state.applyAction(const ProvideManaAction(card: 2));

    expect(state.stack.last, isA<ChannelCardEvent>());

    // Pass until empty.
    state = GameStateTestFunctions.passUntilEmpty(state);

    expect(state.getCardById(2).location, Location.exile);
    expect(state.getCardById(3).location, Location.field);
  });
}
