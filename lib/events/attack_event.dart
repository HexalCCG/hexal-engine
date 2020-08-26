import '../cards/creature.dart';
import '../models/enums/location.dart';
import '../models/game_object_reference.dart';
import '../models/game_state.dart';
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
  final GameObjectReference attacker;

  /// Creature being attacked.
  final GameObjectReference defender;

  /// Should the attacker be exhausted?
  final bool exhaustAttacker;

  /// Should this enable counterattacks this turn?
  final bool enableCounter;

  /// [attacker] attacks [defender]. Exhausts attacker if [exhaustAttacker].
  /// Enables counterattacks this turn if [enableCounter].
  const AttackEvent({
    required this.attacker,
    required this.defender,
    required this.exhaustAttacker,
    required this.enableCounter,
    required bool resolved,
  }) : super(resolved: resolved);

  @override
  bool valid(GameState state) {
    // Get cards from state
    final _attacker = state.getCardById(attacker.id);
    final _defender = state.getCardById(defender.id);

    // Check cards are creatures.
    if (!(_attacker is Creature) || !(_defender is Creature)) {
      return false;
    }

    // Check target creature is still on the field.
    if (_attacker.location != Location.field ||
        _defender.location != Location.field) {
      return false;
    }

    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      return [ResolveEventStateChange(event: this)];
    }

    // Get cards from state
    final _attacker = state.getCardById(attacker.id) as Creature;
    final _defender = state.getCardById(defender.id) as Creature;

    return [
      AddEventStateChange(
          event: DamageCreatureEvent(
              creature: attacker, damage: _defender.attack)),
      AddEventStateChange(
          event: DamageCreatureEvent(
              creature: defender, damage: _attacker.attack)),
      ...exhaustAttacker
          ? [ExhaustCreatureStateChange(creature: attacker)]
          : [],
      ...enableCounter
          ? [const SetCounterAvailableStateChange(enabled: true)]
          : [],
      ResolveEventStateChange(event: this),
    ];
  }

  @override
  AttackEvent get copyResolved => AttackEvent(
      attacker: attacker,
      defender: defender,
      exhaustAttacker: exhaustAttacker,
      enableCounter: enableCounter,
      resolved: true);

  @override
  List<Object> get props =>
      [attacker, defender, exhaustAttacker, enableCounter, resolved];

  /// Create this event from json.
  factory AttackEvent.fromJson(List<dynamic> json) => AttackEvent(
      attacker: GameObjectReference.fromJson(json[0] as int),
      defender: GameObjectReference.fromJson(json[1] as int),
      exhaustAttacker: json[2] as bool,
      enableCounter: json[3] as bool,
      resolved: json[4] as bool);
}
