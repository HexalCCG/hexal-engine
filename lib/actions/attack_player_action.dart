import '../card/creature.dart';
import '../events/attack_player_event.dart';
import '../exceptions/action_exception.dart';
import '../models/enums/location.dart';
import '../models/enums/player.dart';
import '../models/enums/turn_phase.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/priority_state_change.dart';
import '../state_changes/state_change.dart';
import 'action.dart';

/// Declares an attack targeting a player.
class AttackPlayerAction extends Action {
  /// Creature attacking.
  final int attacker;

  /// Player being attacked.
  final Player player;

  /// Causes [attacker] to attack [player].
  const AttackPlayerAction({required this.attacker, required this.player});

  @override
  void validate(GameState state) {
    // Get attacker from state.
    final _attacker = state.getCardById(attacker);

    // Check attacker is a creature.
    if (_attacker is! Creature) {
      throw const ActionException(
          'AttackPlayerAction: Attacker does not implement Creature.');
    }

    // Attack cannot be a reaction.
    if (state.stack.isNotEmpty) {
      throw const ActionException(
          'AttackPlayerAction: Attack cannot be a reaction (stack is not empty).');
    }

    // Check attacker is valid
    // Cannot control opponent's creatures.
    if (_attacker.controller != state.priorityPlayer) {
      throw const ActionException(
          'AttackPlayerAction: Attacker not controlled by priority player.');
    }
    // Can't attack on your opponent's turn.
    if (state.priorityPlayer != state.activePlayer) {
      throw const ActionException(
          'AttackPlayerAction: Priority player is not active');
    }

    // Can't attack players outside of battle phase.
    if (state.turnPhase != TurnPhase.battle) {
      throw const ActionException(
          'AttackPlayerAction: Cannot attack players outside of main battle phase.');
    }

    // Can't attack yourself.
    if (player == state.priorityPlayer) {
      throw const ActionException(
          'AttackPlayerAction: Cannot attack yourself.');
    }
    // Check attacker can attack players
    if (!_attacker.canAttackPlayer(state)) {
      throw const ActionException(
          'AttackPlayerAction: Attacker cannot attack players.');
    }

    // Check opponent's board has no valid targets
    if (state
        .getCardsByLocation(state.notPriorityPlayer, Location.field)
        .where((card) => (card is Creature) && card.canBeAttacked)
        .isNotEmpty) {
      throw const ActionException(
          'AttackPlayerAction: Attack is blocked by one or more creatures.');
    }
  }

  @override
  List<StateChange> apply(GameState state) {
    validate(state);

    return [
      AddEventStateChange(
          event: AttackPlayerEvent(attacker: attacker, player: player)),
      PriorityStateChange(player: state.activePlayer),
    ];
  }

  /// Whether this action can be auto passed.
  static bool canAutoPass(GameState state) {
    if (state.turnPhase == TurnPhase.battle &&
        state.priorityPlayer == state.activePlayer) {
      return false;
    }
    return true;
  }

  @override
  List<Object> get props => [attacker, player];

  /// Create from json.
  static AttackPlayerAction fromJson(List<dynamic> json) => AttackPlayerAction(
        attacker: json[0] as int,
        player: Player.fromIndex(json[1] as int),
      );
}
