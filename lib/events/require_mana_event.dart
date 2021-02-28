import '../models/enums/event_state.dart';
import '../models/enums/location.dart';
import '../models/game_state.dart';
import '../models/mana_amount.dart';
import '../state_changes/move_card_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'event.dart';

/// Require mana for a card.
class RequireManaEvent extends Event {
  /// Cost to require.
  final ManaAmount cost;

  /// Mana already provided.
  final ManaAmount provided;

  /// Card this requirement is for.
  final int card;

  /// Require mana for a card.
  const RequireManaEvent({
    int id = 0,
    EventState state = EventState.unresolved,
    required this.cost,
    required this.card,
    this.provided = const ManaAmount.zero(),
  }) : super(id: id, state: state);

  @override
  bool valid(GameState state) {
    // Check card exists and isn't a player.
    final _card = state.getCardById(card);

    // Check card is in limbo.
    if (_card.location != Location.limbo) {
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

    if (cost.isFilledBy(provided)) {
      // Cost was paid.
      return [
        ResolveEventStateChange(event: this, eventState: EventState.succeeded)
      ];
    } else {
      // Exile summoning card.
      return [
        MoveCardStateChange(card: card, location: Location.exile),
        ResolveEventStateChange(event: this, eventState: EventState.failed)
      ];
    }
  }

  /// Copy this event with the provided mana added.
  RequireManaEvent copyWithProvided(ManaAmount manaProvided) =>
      RequireManaEvent(
        id: id,
        cost: cost,
        provided: provided + manaProvided,
        card: card,
      );

  @override
  RequireManaEvent copyWith({int? id, EventState? state}) => RequireManaEvent(
        id: id ?? this.id,
        state: state ?? this.state,
        cost: cost,
        provided: provided,
        card: card,
      );

  @override
  List<Object> get props => [id, state, cost, provided, card];

  /// Create this event from json.
  static RequireManaEvent fromJson(List<dynamic> json) => RequireManaEvent(
        id: json[0] as int,
        state: EventState.fromIndex(json[1] as int),
        cost: ManaAmount.fromJson(json[2] as List<dynamic>),
        provided: ManaAmount.fromJson(json[3] as List<dynamic>),
        card: json[4] as int,
      );
}
