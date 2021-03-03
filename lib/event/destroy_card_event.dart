import '../model/enums/event_state.dart';
import '../model/enums/location.dart';
import '../model/game_state.dart';
import '../state_change/move_card_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'event.dart';

/// Event that destroys a card.
class DestroyCardEvent extends Event {
  /// Card to destroy.
  final int card;

  /// Destroys [card].
  const DestroyCardEvent({
    int id = 0,
    EventState state = EventState.unresolved,
    required this.card,
  }) : super(id: id, state: state);

  @override
  bool valid(GameState state) {
    final _card = state.getCardById(card);

    // Card must be on field
    if (_card.location != Location.field) {
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
    return [
      MoveCardStateChange(card: card, location: Location.mana),
      ResolveEventStateChange(event: this, eventState: EventState.succeeded),
    ];
  }

  @override
  DestroyCardEvent copyWith({int? id, EventState? state}) => DestroyCardEvent(
      id: id ?? this.id, state: state ?? this.state, card: card);

  @override
  List<Object> get props => [id, state, card];

  /// Create this event from json
  static DestroyCardEvent fromJson(List<dynamic> json) => DestroyCardEvent(
        id: json[0] as int,
        state: EventState.fromIndex(json[1] as int),
        card: json[2] as int,
      );
}
