import 'package:hexal_engine/state_change/exhaust_creature_state_change.dart';
import 'package:hexal_engine/state_change/set_counter_available_state_change.dart';
import 'package:meta/meta.dart';

import '../cards/creature.dart';
import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'damage_creature_event.dart';
import 'event.dart';

class AttackEvent extends Event {
  final Creature attacker;
  final Creature defender;
  final bool exhaustAttacker;
  final bool enableCounter;

  const AttackEvent({
    @required this.attacker,
    @required this.defender,
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
    if (state.getCard(defender).location != Location.field) {
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
