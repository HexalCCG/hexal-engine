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

  @override
  final bool resolved;

  /// Destroys [card].
  const DestroyCardEvent({
    required this.card,
    this.resolved = false,
  });

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
  DestroyCardEvent get copyResolved =>
      DestroyCardEvent(card: card, resolved: true);

  @override
  List<Object> get props => [card, resolved];

  /// Create this event from json
  static DestroyCardEvent fromJson(List<dynamic> json) => DestroyCardEvent(
        card: int.parse(json[0].toString()),
        resolved: json[1] as bool,
      );
}
