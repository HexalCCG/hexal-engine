import '../cards/creature.dart';
import '../events/attack_player_event.dart';
import '../exceptions/action_exception.dart';
import '../models/game_state.dart';
import '../models/location.dart';
import '../models/player.dart';
import '../models/turn_phase.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/priority_state_change.dart';
import '../state_changes/state_change.dart';
import 'action.dart';

/// Declares an attack targeting a player.
class AttackPlayerAction extends Action {
  /// Creature attacking.
  final Creature attacker;

  /// Player being attacked.
  final Player player;

  /// Causes [attacker] to attack [player].
  const AttackPlayerAction({required this.attacker, required this.player});

  @override
  bool valid(GameState state) {
    // Get attacker from state.
    final _attacker = state.getCardById(attacker.id);

    // Check attacker is a creature.
    if (!(_attacker is Creature)) {
      return false;
    }

    // Attack cannot be a reaction.
    if (state.stack.isNotEmpty) {
      return false;
    }

    // Check attacker is valid
    // Cannot control opponent's creatures.
    if (_attacker.controller != state.priorityPlayer) {
      return false;
    }

    // Can't attack players outside of battle phase.
    if (state.turnPhase != TurnPhase.battle) {
      return false;
    }
    // Can't attack on your opponent's turn.
    if (_attacker.controller != state.activePlayer) {
      return false;
    }

    // Can't attack yourself.
    if (player == state.priorityPlayer) {
      return false;
    }
    // Check attacker can attack players
    if (!_attacker.canAttackPlayer) {
      return false;
    }

    // Check opponent's board has no valid targets
    if (state
        .getCardsByLocation(state.notPriorityPlayer, Location.field)
        .where((card) => (card is Creature) && card.canBeAttacked)
        .isNotEmpty) {
      return false;
    }

    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      throw const ActionException(
          'AttackPlayerAction Exception: Attack not valid');
    }

    // Get attacker and defender from state.
    // Creature check done in valid().
    final _attacker = state.getCardById(attacker.id) as Creature;

    return [
      AddEventStateChange(
          event: AttackPlayerEvent(attacker: _attacker, player: player)),
      PriorityStateChange(player: state.activePlayer),
    ];
  }

  @override
  List<Object> get props => [attacker, player];
}
