import '../models/enums/location.dart';
import '../models/game_state.dart';
import '../state_changes/move_card_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'event.dart';

/// Event that destroys a card.
class DestroyCardEvent extends Event {
  /// Card to destroy.
  final int card;

  /// Destroys [card].
  const DestroyCardEvent({
    int id = 0,
    required this.card,
  }) : super(id: id);

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
  List<StateChange> apply(GameState state) => [
        MoveCardStateChange(card: card, location: Location.mana),
        ResolveEventStateChange(event: this),
      ];

  @override
  DestroyCardEvent copyWithId(int id) => DestroyCardEvent(id: id, card: card);

  @override
  List<Object> get props => [id, card];

  /// Create this event from json
  static DestroyCardEvent fromJson(List<dynamic> json) => DestroyCardEvent(
        id: json[0] as int,
        card: json[1] as int,
      );
}
