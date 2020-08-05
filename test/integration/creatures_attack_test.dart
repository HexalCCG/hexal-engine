import 'package:test/test.dart';
import 'package:hexal_engine/cards/creature.dart';
import 'package:hexal_engine/cards/sample/001_cow_creature_card.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/turn_phase.dart';

void main() {
  test('Creatures can attack correctly. ', () {
    const attacker1 = CowCreatureCard(
      id: 2,
      controller: Player.one,
      owner: Player.one,
      location: Location.field,
    );
    const attacker2 = CowCreatureCard(
      id: 3,
      controller: Player.one,
      owner: Player.one,
      location: Location.field,
    );
    const defender = CowCreatureCard(
      id: 4,
      controller: Player.one,
      owner: Player.one,
      location: Location.hand,
    );
    var state = const GameState(
      gameOverState: GameOverState.playing,
      cards: [attacker1, attacker2, defender],
      stack: [],
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.main1,
    );

    expect(
        (state.cards.firstWhere((element) => element.id == 3) as Creature)
            .damage,
        1);
  });
}
