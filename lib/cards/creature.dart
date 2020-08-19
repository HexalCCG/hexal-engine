import '../models/card_object.dart';
import '../models/location.dart';
import '../models/player.dart';
import 'i_permanent.dart';

/// Permanent card with stats that can attack and block attacks.
abstract class Creature extends CardObject implements IPermanent {
  /// Damage taken this turn.
  final int damage;

  /// Determines what attacks are valid this turn.
  final bool enteredFieldThisTurn;

  /// Whether this already attacked this turn.
  final bool exhausted;

  /// [id] must be unique. [owner] cannot be changed.
  const Creature(
      {required int id,
      required Player owner,
      required Player controller,
      required Location location,
      required this.damage,
      required this.enteredFieldThisTurn,
      required this.exhausted})
      : super(id: id, owner: owner, controller: controller, location: location);

  /// Health written on the card.
  int get baseHealth;

  /// Attack written on the card.
  int get baseAttack;

  /// Current total health.
  int get health => baseHealth - damage;

  /// Current total attack.
  int get attack => baseAttack;

  /// Allowed to attack creatures?
  bool get canAttack => !enteredFieldThisTurn && !exhausted;

  /// Allowed to attack players?
  bool get canAttackPlayer => canAttack;

  /// Whether this can be targeted by attacks, and whether this blocks.
  bool get canBeAttacked => true;

  /// Copy changing creature parameters [exhausted], [enteredFieldThisTurn],
  /// [damage].
  Creature copyWithCreature(
      {bool? exhausted, bool? enteredFieldThisTurn, int? damage});

  @override
  List<Object> get toStringProps =>
      [...super.toStringProps, damage, enteredFieldThisTurn, exhausted];
}
