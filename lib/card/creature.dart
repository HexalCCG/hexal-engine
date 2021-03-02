import 'card.dart';
import '../models/game_state.dart';

/// Permanent card with stats that can attack and block attacks.
mixin Creature on Card {
  @override
  bool get permanent => true;

  /// Damage taken this turn.
  int get damage;

  /// Health written on the card.
  int get baseHealth;

  /// Attack written on the card.
  int get baseAttack;

  /// Current total health.
  int get health => baseHealth - damage;

  /// Current total attack.
  int get attack => baseAttack;

  /// Allowed to attack creatures?
  bool canAttack(GameState state) =>
      !state.history.enteredFieldThisTurn.contains(id) &&
      !state.history.attackedThisTurn.contains(id);

  /// Allowed to attack players?
  bool canAttackPlayer(GameState state) =>
      !state.history.enteredFieldThisTurn.contains(id) &&
      !state.history.attackedThisTurn.contains(id);

  /// Whether this can be targeted by attacks, and whether this blocks.
  bool get canBeAttacked => true;

  /// Copy this with creature fields modified.
  Card copyWithCreature({
    int? damage,
  });
}
