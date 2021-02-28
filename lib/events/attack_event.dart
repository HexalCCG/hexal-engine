import 'dart:html';

import '../card/creature.dart';
import '../models/enums/event_state.dart';
import '../models/enums/location.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/history_attacked_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/set_counter_available_state_change.dart';
import '../state_changes/state_change.dart';
import 'damage_creature_event.dart';
import 'event.dart';

/// Event representing one creature attacking another.
class AttackEvent extends Event {
  /// Creature that is attacking.
  final int attacker;

  /// Creature being attacked.
  final int defender;

  /// Should this enable counterattacks this turn?
  final bool enableCounter;

  /// [attacker] attacks [defender].
  const AttackEvent({
    int id = 0,
    EventState state = EventState.unresolved,
    required this.attacker,
    required this.defender,
    this.enableCounter = true,
  }) : super(id: id, state: state);

  @override
  bool valid(GameState state) {
    // Get cards from state
    final _attacker = state.getCardById(attacker);
    final _defender = state.getCardById(defender);

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
    final _attacker = state.getCardById(attacker) as Creature;
    final _defender = state.getCardById(defender) as Creature;

    return [
      AddEventStateChange(
          event: DamageCreatureEvent(
              creature: attacker, damage: _defender.attack)),
      AddEventStateChange(
          event: DamageCreatureEvent(
              creature: defender, damage: _attacker.attack)),
      ...enableCounter
          ? [const SetCounterAvailableStateChange(enabled: true)]
          : [],
      // Add this attack to the history.
      HistoryAttackedStateChange(creature: attacker),
      ResolveEventStateChange(event: this),
    ];
  }

  @override
  AttackEvent copyWith({int? id, EventState? state}) => AttackEvent(
        id: id ?? this.id,
        state: state ?? this.state,
        attacker: attacker,
        defender: defender,
        enableCounter: enableCounter,
      );

  @override
  List<Object> get props => [id, state, attacker, defender, enableCounter];

  /// Create this event from json.
  static AttackEvent fromJson(List<dynamic> json) => AttackEvent(
        id: json[0] as int,
        state: EventState.fromIndex(json[1] as int),
        attacker: json[2] as int,
        defender: json[3] as int,
        enableCounter: json[4] as bool,
      );
}
