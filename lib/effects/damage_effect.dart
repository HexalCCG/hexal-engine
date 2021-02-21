import '../card/creature.dart';
import '../events/damage_creature_event.dart';
import '../events/damage_player_event.dart';
import '../models/enums/player.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/modify_event_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'effect.dart';
import 'target/target.dart';
import 'targeted_effect.dart';

/// Deals damage to a target.
class DamageEffect extends Effect with TargetedEffect {
  /// Amount of damage to deal.
  final int damage;

  @override
  final Target target;
  @override
  final bool targetFilled;
  @override
  final List<int> targets;

  @override
  final Player controller;
  @override
  final bool resolved;

  /// [target] is target to request. [targetResult] returns from the request.
  /// [targetIndex] counts through list of targets to apply damage.
  const DamageEffect({
    required this.damage,
    required this.target,
    this.targetFilled = false,
    this.targets = const [],
    required this.controller,
    this.resolved = false,
  });

  @override
  bool valid(GameState state) {
    // Target should be filled before this is applied.
    if (!targetFilled) {
      return false;
    }

    // Check all targets exist in state.
    for (final ref in targets) {
      state.getCardById(ref);
    }

    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      return [ResolveEventStateChange(event: this)];
    }

    if (targets.isEmpty) {
      // If there are no targets, resolve this.
      return [ResolveEventStateChange(event: this)];
    }

    // If only one target is left, do it and resolve
    if (targets.length == 1) {
      return [
        _generateStateChange(state, targets.first),
        ResolveEventStateChange(event: this),
      ];
    }

    // Otherwise do one target and increment
    return [
      _generateStateChange(state, targets.first),
      ModifyEventStateChange(
        event: this,
        newEvent: DamageEffect(
            damage: damage,
            target: target,
            targetFilled: targetFilled,
            targets: targets.skip(1).toList(),
            controller: controller,
            resolved: resolved),
      ),
    ];
  }

  StateChange _generateStateChange(GameState state, int reference) {
    // If target is a player.
    if (reference < 2) {
      return AddEventStateChange(
          event: DamagePlayerEvent(
              player: Player.fromIndex(reference), damage: damage));
    } else {
      final _object = state.getCardById(reference);

      if (_object is Creature) {
        return AddEventStateChange(
            event: DamageCreatureEvent(creature: reference, damage: damage));
      } else {
        throw ArgumentError(
            'ID provided to damage effect was not a player or creature.');
      }
    }
  }

  @override
  DamageEffect copyFilled(List<int> _targets) => DamageEffect(
      damage: damage,
      target: target,
      targetFilled: true,
      targets: _targets,
      controller: controller,
      resolved: resolved);

  @override
  DamageEffect get copyResolved => DamageEffect(
      damage: damage,
      target: target,
      targetFilled: targetFilled,
      targets: targets,
      controller: controller,
      resolved: true);

  @override
  List<Object> get props => [
        damage,
        target,
        targetFilled,
        targets,
        controller,
        resolved,
      ];

  /// Create this effect from json.
  static DamageEffect fromJson(List<dynamic> json) => DamageEffect(
      damage: json[0] as int,
      target: Target.fromJson(json[1] as Map<String, dynamic>),
      targetFilled: json[2] as bool,
      targets: (json[3] as List<dynamic>)
          .map((dynamic e) => int.parse(e.toString()))
          .toList(),
      controller: Player.fromIndex(json[4] as int),
      resolved: json[5] as bool);
}
