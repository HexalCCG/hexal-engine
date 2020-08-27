import '../cards/creature.dart';
import '../models/enums/location.dart';
import '../models/game_object_reference.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/damage_creature_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'damage_event.dart';
import 'destroy_card_event.dart';
import 'event.dart';

/// Event dealing damage to a creature.
class DamageCreatureEvent extends Event implements DamageEvent {
  /// Creature to be damaged.
  final GameObjectReference creature;

  /// Amount of damage to deal.
  final int damage;

  @override
  final bool resolved;

  /// [creature] is dealt [damage] damage.
  const DamageCreatureEvent({
    required this.creature,
    required this.damage,
    this.resolved = false,
  });

  @override
  bool valid(GameState state) {
    final _creature = state.getCardById(creature.id);

    /// Check creature is a creature.
    if (!(_creature is Creature)) {
      return false;
    }

    // Check creature is still on the battlefield.
    if (_creature.location != Location.field) {
      return false;
    }

    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      return [ResolveEventStateChange(event: this)];
    }

    final _creature = state.getCardById(creature.id) as Creature;

    if (_creature.damage + damage > _creature.health) {
      return [
        DamageCreatureStateChange(
            creature: GameObjectReference(id: _creature.id), damage: damage),
        ResolveEventStateChange(event: this),
        AddEventStateChange(event: DestroyCardEvent(card: creature)),
      ];
    } else {
      return [
        DamageCreatureStateChange(creature: creature, damage: damage),
        ResolveEventStateChange(event: this),
      ];
    }
  }

  @override
  DamageCreatureEvent get copyResolved =>
      DamageCreatureEvent(creature: creature, damage: damage, resolved: true);

  @override
  List<Object> get props => [creature, damage, resolved];

  /// Create this event from json.
  static DamageCreatureEvent fromJson(List<dynamic> json) =>
      DamageCreatureEvent(
          creature: GameObjectReference.fromJson(json[0] as int),
          damage: json[1] as int,
          resolved: json[2] as bool);
}
