import 'package:hexal_engine/models/game_object_reference.dart';

import '../cards/creature.dart';
import '../models/enums/location.dart';
import '../models/enums/player.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/exhaust_creature_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/set_counter_available_state_change.dart';
import '../state_changes/state_change.dart';
import 'damage_player_event.dart';
import 'event.dart';

/// Event for a creature attacking a player.
class AttackPlayerEvent extends Event {
  /// Creature attacking.
  final GameObjectReference attacker;

  /// Player being attacked.
  final GameObjectReference player;

  /// Should the attacker be exhausted?
  final bool exhaustAttacker;

  /// Should this enable counterattacks this turn?
  final bool enableCounter;

  /// [attacker] attacks [player]. Exhausts attacker if [exhaustAttacker].
  /// Enables counterattacks this turn if [enableCounter].
  const AttackPlayerEvent({
    required this.attacker,
    required this.player,
    this.exhaustAttacker = true,
    this.enableCounter = true,
    bool resolved = false,
  }) : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    if (attacker.location != Location.field) {
      return [ResolveEventStateChange(event: this)];
    } else {
      return [
        AddEventStateChange(
            event: DamagePlayerEvent(player: player, damage: attacker.attack)),
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

  @override
  AttackPlayerEvent get copyResolved => AttackPlayerEvent(
      attacker: attacker,
      player: player,
      exhaustAttacker: exhaustAttacker,
      enableCounter: enableCounter,
      resolved: true);

  @override
  List<Object> get props =>
      [attacker, player, exhaustAttacker, enableCounter, resolved];

  /// Create this event from json.
  factory AttackPlayerEvent.fromJson(List<dynamic> json) => AttackPlayerEvent(
      attacker: GameObjectReference.fromJson(json[0] as int),
      player: GameObjectReference.fromJson(json[1] as int),
      exhaustAttacker: json[2] as bool,
      enableCounter: json[3] as bool,
      resolved: json[4] as bool);
}
