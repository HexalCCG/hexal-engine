import '../models/card.dart';

/// Permanent card with stats that can attack and block attacks.
mixin Creature on Card {
  @override
  bool get permanent => true;

  /// Damage taken this turn.
  int get damage;

  /// Determines what attacks are valid this turn.
  bool get enteredFieldThisTurn;

  /// Whether this already attacked this turn.
  bool get exhausted;

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
  bool get canAttackPlayer => !enteredFieldThisTurn && !exhausted;

  /// Whether this can be targeted by attacks, and whether this blocks.
  bool get canBeAttacked => true;

  /// Copy this with creature fields modified.
  Card copyWithCreature({
    bool? exhausted,
    bool? enteredFieldThisTurn,
    int? damage,
  });
}
