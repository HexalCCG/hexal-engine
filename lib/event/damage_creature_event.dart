import '../card/creature.dart';
import '../model/enums/event_state.dart';
import '../model/enums/location.dart';
import '../model/game_state.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/damage_creature_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'damage_event.dart';
import 'destroy_card_event.dart';
import 'event.dart';

/// Event dealing damage to a creature.
class DamageCreatureEvent extends Event implements DamageEvent {
  /// Creature to be damaged.
  final int creature;

  /// Amount of damage to deal.
  final int damage;

  /// [creature] is dealt [damage] damage.
  const DamageCreatureEvent({
    int id = 0,
    EventState state = EventState.unresolved,
    required this.creature,
    required this.damage,
  }) : super(id: id, state: state);

  @override
  bool valid(GameState state) {
    final _creature = state.getCardById(creature);

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
      return [
        ResolveEventStateChange(event: this, eventState: EventState.failed)
      ];
    }

    final _creature = state.getCardById(creature) as Creature;

    if (_creature.damage + damage >= _creature.health) {
      return [
        DamageCreatureStateChange(creature: _creature.id, damage: damage),
        ResolveEventStateChange(event: this, eventState: EventState.succeeded),
        AddEventStateChange(event: DestroyCardEvent(card: creature)),
      ];
    } else {
      return [
        DamageCreatureStateChange(creature: creature, damage: damage),
        ResolveEventStateChange(event: this, eventState: EventState.succeeded),
      ];
    }
  }

  @override
  DamageCreatureEvent copyWith({int? id, EventState? state}) =>
      DamageCreatureEvent(
          id: id ?? this.id,
          state: state ?? this.state,
          creature: creature,
          damage: damage);

  @override
  List<Object> get props => [id, state, creature, damage];

  /// Create this event from json.
  static DamageCreatureEvent fromJson(List<dynamic> json) =>
      DamageCreatureEvent(
        id: json[0] as int,
        state: EventState.fromIndex(json[1] as int),
        creature: json[2] as int,
        damage: json[3] as int,
      );
}
