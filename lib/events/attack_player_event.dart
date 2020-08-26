import '../cards/creature.dart';
import '../models/enums/location.dart';
import '../models/game_object_reference.dart';
import '../models/game_state.dart';
import '../models/player_object.dart';
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

  @override
  final bool resolved;

  /// [attacker] attacks [player]. Exhausts attacker if [exhaustAttacker].
  /// Enables counterattacks this turn if [enableCounter].
  const AttackPlayerEvent({
    required this.attacker,
    required this.player,
    this.exhaustAttacker = true,
    this.enableCounter = true,
    this.resolved = false,
  });

  @override
  bool valid(GameState state) {
    final _attacker = state.getGameObjectById(attacker.id);
    final _player = state.getGameObjectById(player.id);

    // Check if attacker is valid
    if (!(_attacker is Creature) || _attacker.location != Location.field) {
      return false;
    }
    // Check if player is valid
    if (!(_player is PlayerObject)) {
      return false;
    }

    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      return [ResolveEventStateChange(event: this)];
    }

    // Casts safe because of valid check above.
    final _attacker = state.getGameObjectById(attacker.id) as Creature;
    final _player = state.getGameObjectById(player.id) as PlayerObject;

    return [
      AddEventStateChange(
          event: DamagePlayerEvent(player: _player, damage: _attacker.attack)),
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
