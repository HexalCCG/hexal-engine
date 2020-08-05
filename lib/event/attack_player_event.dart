import 'package:hexal_engine/state_change/exhaust_creature_state_change.dart';
import 'package:hexal_engine/state_change/set_counter_available_state_change.dart';
import 'package:meta/meta.dart';

import '../cards/creature.dart';
import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../game_state/player.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'damage_player_event.dart';
import 'event.dart';

class AttackPlayerEvent extends Event {
  final Creature attacker;
  final Player player;
  final bool exhaustAttacker;
  final bool enableCounter;

  const AttackPlayerEvent({
    @required this.attacker,
    @required this.player,
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
