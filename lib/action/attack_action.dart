import '../card/creature.dart';
import '../event/attack_event.dart';
import '../exceptions/action_exception.dart';
import '../model/enums/location.dart';
import '../model/enums/turn_phase.dart';
import '../model/game_state.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/priority_state_change.dart';
import '../state_change/state_change.dart';
import 'action.dart';

/// Declares an attack targeting a creature.
class AttackAction extends Action {
  /// Creature attacking.
  final int attacker;

  /// Creature defending.
  final int defender;

  /// Causes [attacker] to attack [defender].
  const AttackAction({required this.attacker, required this.defender});

  @override
  void validate(GameState state) {
    // Attack cannot be a reaction.
    if (state.stack.isNotEmpty) {
      throw const ActionException(
          'AttackAction: Attack cannot be a reaction (stack is not empty).');
    }

    // Get attacker and defender from state.
    final _attacker = state.getCardById(attacker);
    final _defender = state.getCardById(defender);

    // Check attacker and defender are creatures.
    if (_attacker is! Creature) {
      throw const ActionException(
          'AttackAction: Attacker does not implement Creature.');
    }
    if (_defender is! Creature) {
      throw const ActionException(
          'AttackAction: Defender does not implement Creature. (Did you mean AttackPlayerAction?)');
    }

    // Check attacker is valid
    // Cannot control opponent's creatures.
    if (_attacker.controller != state.priorityPlayer) {
      throw const ActionException(
          'AttackAction: Attacker is not controller by priority player.');
    }
    // Check if attacker can attack.
    if (!_attacker.canAttack(state)) {
      throw const ActionException('AttackAction: Attacker cannot attack.');
    }
    // Cannot attack your own creatures
    if (_defender.controller == state.priorityPlayer) {
      throw const ActionException(
          'AttackAction: Defender controlled by priority player.');
    }
    // Check if creature is being protected.
    if (!_defender.canBeAttacked) {
      throw const ActionException('AttackAction: Defender cannot be attacked.');
    }
    // Cannot attack creatures not in field.
    if (_defender.location != Location.field) {
      throw const ActionException('AttackAction: Defender not in field.');
    }

    // Check phase.
    // Counterattack.
    // Can't counter on your turn.
    if (state.turnPhase == TurnPhase.counter) {
      if (state.priorityPlayer == state.activePlayer) {
        throw const ActionException(
            'AttackAction: Active player cannot counter.');
      }
    }
    // Normal attack.
    // Can't attack if not active player.
    else if (state.turnPhase == TurnPhase.battle) {
      if (state.priorityPlayer != state.activePlayer) {
        throw const ActionException(
            'AttackAction: Inactive player cannot attack.');
      }
    } else {
      throw const ActionException('AttackAction: Incorrect phase.');
    }
  }

  @override
  List<StateChange> apply(GameState state) {
    validate(state);

    return [
      AddEventStateChange(
          event: AttackEvent(attacker: attacker, defender: defender)),
      PriorityStateChange(player: state.activePlayer),
    ];
  }

  /// Whether this action can be auto passed.
  static bool canAutoPass(GameState state) {
    if (state.turnPhase == TurnPhase.battle &&
        state.priorityPlayer == state.activePlayer &&
        state.stack.isEmpty) {
      return false;
    }
    if (state.turnPhase == TurnPhase.counter &&
        state.priorityPlayer != state.activePlayer &&
        state.stack.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  List<Object> get props => [attacker, defender];

  /// Create from json.
  static AttackAction fromJson(List<dynamic> json) => AttackAction(
        attacker: json[0] as int,
        defender: json[1] as int,
      );
}
