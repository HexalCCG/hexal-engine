import '../models/game_state.dart';
import 'creature.dart';

/// Permanent card with stats that can attack and block attacks.
mixin Ready on Creature {
  /// Can attack even if it entered the field this turn.
  @override
  bool canAttack(GameState state) =>
      !state.history.attackedThisTurn.contains(id);

  /// Do not override player attack as player attacks are not changed.
  // @override
  // bool canAttackPlayer(GameState state) => !state.history.attackedThisTurn(id);
}
