import 'package:hexal_engine/models/card_object.dart';
import 'package:hexal_engine/models/game_object_reference.dart';

import '../cards/creature.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/damage_creature_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'destroy_card_event.dart';
import 'event.dart';

/// Event dealing damage to a creature.
class DamageCreatureEvent extends Event {
  /// Creature to be damaged.
  final GameObjectReference creature;

  /// Amount of damage to deal.
  final int damage;

  /// [creature] is dealt [damage] damage.
  const DamageCreatureEvent(
      {required this.creature, required this.damage, bool resolved = false})
      : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    if (creature.damage + damage > creature.health) {
      return [
        DamageCreatureStateChange(creature: creature, damage: damage),
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
  factory DamageCreatureEvent.fromJson(List<dynamic> json) =>
      DamageCreatureEvent(
          creature: GameObjectReference.fromJson(json[0] as int),
          damage: json[1] as int,
          resolved: json[2] as bool);
}
