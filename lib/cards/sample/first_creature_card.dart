import 'package:hexal_engine/cards/creature_card.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/player.dart';

class FirstCreatureCard extends CreatureCard {
  const FirstCreatureCard(
      {Player owner,
      Player controller,
      Location location,
      bool enteredFieldThisTurn,
      int damage})
      : super(
            owner: owner,
            controller: controller,
            location: location,
            enteredFieldThisTurn: enteredFieldThisTurn,
            damage: damage);

  @override
  int get baseAttack => 1;

  @override
  int get baseHealth => 1;
}
