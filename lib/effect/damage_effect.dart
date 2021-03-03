import '../card/creature.dart';
import '../event/damage_creature_event.dart';
import '../event/damage_player_event.dart';
import '../event/event.dart';
import '../model/enums/event_state.dart';
import '../model/enums/player.dart';
import '../model/game_state.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/modify_event_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'effect.dart';
import 'target/target.dart';
import 'targeted_effect.dart';

/// Deals damage to a target.
class DamageEffect extends Event with Effect, TargetedEffect {
  /// Amount of damage to deal.
  final int damage;

  // Fields overridden from targeted effect
  @override
  final Player controller;
  @override
  final Target target;
  @override
  final bool targetFilled;
  @override
  final List<int> targets;

  /// [target] is target to request. [targetResult] returns from the request.
  /// [targetIndex] counts through list of targets to apply damage.
  const DamageEffect({
    int id = 0,
    EventState state = EventState.unresolved,
    required this.controller,
    required this.damage,
    required this.target,
    this.targetFilled = false,
    this.targets = const [],
  }) : super(id: id, state: state);

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
      return [
        ResolveEventStateChange(event: this, eventState: EventState.failed)
      ];
    }

    if (targets.isEmpty) {
      // If there are no targets, resolve this.
      return [
        ResolveEventStateChange(event: this, eventState: EventState.failed)
      ];
    }

    // If only one target is left, do it and resolve
    if (targets.length == 1) {
      return [
        _generateStateChange(state, targets.first),
        ResolveEventStateChange(event: this, eventState: EventState.succeeded),
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
        ),
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
  DamageEffect copyWith({int? id, EventState? state}) => DamageEffect(
        id: id ?? this.id,
        state: state ?? this.state,
        damage: damage,
        target: target,
        targetFilled: targetFilled,
        targets: targets,
        controller: controller,
      );

  @override
  DamageEffect copyFilled(List<int> _targets) => DamageEffect(
        id: id,
        damage: damage,
        target: target,
        targetFilled: true,
        targets: _targets,
        controller: controller,
      );

  @override
  List<Object> get props => [
        id,
        state,
        damage,
        target,
        targetFilled,
        targets,
        controller,
      ];

  /// Create this effect from json.
  static DamageEffect fromJson(List<dynamic> json) => DamageEffect(
        id: json[0] as int,
        state: EventState.fromIndex(json[1] as int),
        damage: json[2] as int,
        target: Target.fromJson(json[3] as Map<String, dynamic>),
        targetFilled: json[4] as bool,
        targets: (json[5] as List<dynamic>).cast<int>().toList(),
        controller: Player.fromIndex(json[6] as int),
      );
}
