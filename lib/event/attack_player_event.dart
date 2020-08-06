import '../cards/creature.dart';
import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../game_state/player.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/exhaust_creature_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/set_counter_available_state_change.dart';
import '../state_change/state_change.dart';
import 'damage_player_event.dart';
import 'event.dart';

/// Event for a creature attacking a player.
class AttackPlayerEvent extends Event {
  /// Creature attacking.
  final Creature attacker;

  /// Player being attacked.
  final Player player;

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
  AttackPlayerEvent get copyResolved =>
      AttackPlayerEvent(attacker: attacker, player: player, resolved: true);

  @override
  List<Object> get props => [attacker, player, resolved];
}
