import '../models/card_object.dart';
import '../models/game_state.dart';
import '../models/location.dart';
import '../state_changes/move_card_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'event.dart';

/// Event that destroys a card.
class DestroyCardEvent extends Event {
  /// Card to destroy.
  final CardObject card;

  /// Destroys [card].
  const DestroyCardEvent({required this.card, bool resolved = false})
      : super(resolved: resolved);

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
}
