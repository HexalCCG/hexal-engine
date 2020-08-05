import 'package:meta/meta.dart';

import '../../game_state/location.dart';
import '../../game_state/player.dart';
import '../creature.dart';

class CowCreatureCard extends Creature {
  const CowCreatureCard({
    @required int id,
    @required Player owner,
    @required Player controller,
    @required Location location,
    bool exhausted = false,
    bool enteredFieldThisTurn = false,
    int damage = 0,
  }) : super(
            id: id,
            owner: owner,
            controller: controller,
            location: location,
            enteredFieldThisTurn: enteredFieldThisTurn,
            exhausted: exhausted,
            damage: damage);

  @override
  CowCreatureCard copyWith(Map<String, dynamic> data) => CowCreatureCard(
        id: id,
        owner: owner,
        controller: data['controller'] ?? controller,
        location: data['location'] ?? location,
        exhausted: data['exhausted'] ?? exhausted,
        enteredFieldThisTurn:
            data['enteredFieldThisTurn'] ?? enteredFieldThisTurn,
        damage: data['damage'] ?? damage,
      );

  @override
  int get baseAttack => 2;
  @override
  int get baseHealth => 2;
}
