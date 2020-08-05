import 'package:meta/meta.dart';

import '../game_state/location.dart';
import '../game_state/player.dart';
import '../objects/card_object.dart';
import 'i_permanent.dart';

abstract class Creature extends CardObject implements IPermanent {
  // Variable
  final int damage;
  final bool enteredFieldThisTurn;
  final bool exhausted;

  const Creature(
      {@required int id,
      @required Player owner,
      @required Player controller,
      @required Location location,
      @required this.damage,
      @required this.enteredFieldThisTurn,
      @required this.exhausted})
      : super(id: id, owner: owner, controller: controller, location: location);

  // Constant
  int get baseHealth;
  int get baseAttack;

  // Derived
  int get health => baseHealth - damage;
  int get attack => baseAttack;
  bool get canAttack => !enteredFieldThisTurn && !exhausted;
  bool get canAttackPlayer => canAttack;
  bool get canBeAttacked => true;

  @override
  List<Object> get toStringProps =>
      [...super.toStringProps, damage, enteredFieldThisTurn, exhausted];
}
