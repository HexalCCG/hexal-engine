import '../cards/creature.dart';
import '../events/attack_event.dart';
import '../exceptions/action_exception.dart';
import '../models/card_object.dart';
import '../models/enums/location.dart';
import '../models/enums/turn_phase.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/priority_state_change.dart';
import '../state_changes/state_change.dart';
import 'action.dart';

/// Declares an attack targeting a creature.
class AttackAction extends Action {
  /// Creature attacking.
  final CardObject attacker;

  /// Creature defending.
  final CardObject defender;

  /// Causes [attacker] to attack [defender].
  const AttackAction({required this.attacker, required this.defender});

  @override
  bool valid(GameState state) {
    // Attack cannot be a reaction.
    if (state.stack.isNotEmpty) {
      return false;
    }

    // Get attacker and defender from state.
    final _attacker = state.getCardById(attacker.id);
    final _defender = state.getCardById(defender.id);

    // Check attacker and defender are creatures.
    if (!(_attacker is Creature && _defender is Creature)) {
      return false;
    }

    // Check attacker is valid
    // Cannot control opponent's creatures.
    if (_attacker.controller != state.priorityPlayer) {
      return false;
    }

    // Normal attack.
    if (state.turnPhase == TurnPhase.battle) {
      // Can't attack on your opponent's turn.
      if (_attacker.controller != state.activePlayer) {
        return false;
      }

      // Check if attacker can attack.
      if (!_attacker.canAttack) {
        return false;
      }

      // Cannot attack your own creatures
      if (_defender.controller == state.activePlayer) {
        return false;
      }

      // Check if creature is being protected.
      if (!_defender.canBeAttacked) {
        return false;
      }

      // Cannot attack creatures not in field.
      if (_defender.location != Location.field) {
        return false;
      }

      return true;
    }

    // Counterattack.
    if (state.turnPhase == TurnPhase.counter) {
      // Can't counter on your turn.
      if (_attacker.controller != state.notActivePlayer) {
        return false;
      }

      // Check if attacker can attack.
      if (!_attacker.canAttack) {
        return false;
      }

      // Check if creature is being protected.
      if (!_defender.canBeAttacked) {
        return false;
      }

      // Cannot attack your own creatures
      if (_defender.controller == state.activePlayer) {
        return false;
      }

      // Cannot attack creatures not in field.
      if (_defender.location != Location.field) {
        return false;
      }

      return true;
    }

    // Not in the correct phase.
    return false;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      throw const ActionException('AttackAction Exception: Attack not valid');
    }
    // Get attacker and defender from state.
    // Casts safe as valid check above already checks them.
    final _attacker = state.getCardById(attacker.id) as Creature;
    final _defender = state.getCardById(defender.id) as Creature;

    return [
      AddEventStateChange(
          event: AttackEvent(attacker: _attacker, defender: _defender)),
      PriorityStateChange(player: state.activePlayer),
    ];
  }

  @override
  List<Object> get props => [attacker, defender];
}
