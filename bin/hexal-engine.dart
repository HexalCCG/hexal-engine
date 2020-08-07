import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/cards/sample/002_cow_beam_card.dart';
import 'package:hexal_engine/event/draw_card_event.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main(List<String> arguments) {
  var state = GameState(
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.start,
      counterAvailable: false,
      gameOverState: GameOverState.playing,
      cards: [
        CowCreatureCard(
          id: 2,
          owner: Player.one,
          controller: Player.one,
          location: Location.deck,
          damage: 0,
          enteredFieldThisTurn: false,
          exhausted: false,
        ),
        CowCreatureCard(
          id: 3,
          owner: Player.one,
          controller: Player.one,
          location: Location.deck,
          damage: 0,
          enteredFieldThisTurn: false,
          exhausted: false,
        ),
        CowCreatureCard(
          id: 4,
          owner: Player.one,
          controller: Player.one,
          location: Location.deck,
          damage: 0,
          enteredFieldThisTurn: false,
          exhausted: false,
        ),
        CowCreatureCard(
          id: 5,
          owner: Player.one,
          controller: Player.one,
          location: Location.deck,
          damage: 0,
          enteredFieldThisTurn: false,
          exhausted: false,
        ),
        CowCreatureCard(
          id: 6,
          owner: Player.one,
          controller: Player.one,
          location: Location.deck,
          damage: 0,
          enteredFieldThisTurn: false,
          exhausted: false,
        ),
        CowBeamCard(
          id: 7,
          owner: Player.one,
          controller: Player.one,
          location: Location.deck,
        ),
        CowBeamCard(
          id: 8,
          owner: Player.one,
          controller: Player.one,
          location: Location.deck,
        ),
        CowBeamCard(
          id: 9,
          owner: Player.one,
          controller: Player.one,
          location: Location.deck,
        ),
        CowBeamCard(
          id: 10,
          owner: Player.one,
          controller: Player.one,
          location: Location.deck,
        ),
        CowBeamCard(
          id: 11,
          owner: Player.one,
          controller: Player.one,
          location: Location.deck,
        ),
      ],
      stack: []);

  state = state.addAndResolveEvent(DrawCardEvent(player: Player.one, draws: 3));
  state = state.addAndResolveEvent(DrawCardEvent(player: Player.two, draws: 4));

  print(state);
}
