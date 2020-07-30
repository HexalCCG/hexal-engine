import 'package:meta/meta.dart';

import '../../game_state/location.dart';
import '../../game_state/player.dart';
import '../../objects/card_object.dart';
import '../mi_creature.dart';

class CowCreatureCard extends CardObject with MCreature implements ICreature {
  @override
  final int damage;

  const CowCreatureCard({
    @required int id,
    @required Player owner,
    @required Player controller,
    @required Location location,
    bool enteredFieldThisTurn,
    this.damage = 0,
  }) : super(
            id: id,
            owner: owner,
            controller: controller,
            location: location,
            enteredFieldThisTurn: enteredFieldThisTurn);

  @override
  CowCreatureCard copyWith(Map<String, dynamic> data) => CowCreatureCard(
        id: id,
        owner: owner,
        controller: data['controller'] ?? controller,
        location: data['location'] ?? location,
        enteredFieldThisTurn:
            data['enteredFieldThisTurn'] ?? enteredFieldThisTurn,
        damage: data['damage'] ?? damage,
      );

  @override
  int get baseAttack => 2;
  @override
  int get baseHealth => 2;
}
