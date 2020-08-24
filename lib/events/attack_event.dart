import '../cards/creature.dart';
import '../models/game_state.dart';
import '../models/location.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/exhaust_creature_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/set_counter_available_state_change.dart';
import '../state_changes/state_change.dart';
import 'damage_creature_event.dart';
import 'event.dart';

/// Event representing one creature attacking another.
class AttackEvent extends Event {
  /// Creature that is attacking.
  final Creature attacker;

  /// Creature being attacked.
  final Creature defender;

  /// Should the attacker be exhausted?
  final bool exhaustAttacker;

  /// Should this enable counterattacks this turn?
  final bool enableCounter;

  /// [attacker] attacks [defender]. Exhausts attacker if [exhaustAttacker].
  /// Enables counterattacks this turn if [enableCounter].
  const AttackEvent({
    required this.attacker,
    required this.defender,
    this.exhaustAttacker = true,
    this.enableCounter = true,
    bool resolved = false,
  }) : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    if (!_validate(state)) {
      return [ResolveEventStateChange(event: this)];
    } else {
      return [
        AddEventStateChange(
            event: DamageCreatureEvent(
                creature: attacker, damage: defender.attack)),
        AddEventStateChange(
            event: DamageCreatureEvent(
                creature: defender, damage: attacker.attack)),
        ...exhaustAttacker
            ? [ExhaustCreatureStateChange(creature: attacker)]
            : [],
        ...enableCounter
            ? [const SetCounterAvailableStateChange(enabled: true)]
            : [],
        ResolveEventStateChange(event: this),
      ];
    }
  }

  bool _validate(GameState state) {
    // Check target creature is still on the field.
    if (state.getCardById(defender.id).location != Location.field) {
      return false;
    }

    // Check attacker is still on the field
    if (attacker.location != Location.field) {
      return false;
    }
    return true;
  }

  @override
  AttackEvent get copyResolved =>
      AttackEvent(attacker: attacker, defender: defender, resolved: true);

  @override
  List<Object> get props => [attacker, defender, resolved];
}
