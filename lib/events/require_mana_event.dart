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
    required this.cost,
    required this.card,
    this.provided = const ManaAmount.zero(),
    int id = 0,
    bool resolved = false,
  }) : super(id: id, resolved: resolved);

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
      return [ResolveEventStateChange(event: this)];
    }

    if (cost.isFilledBy(provided)) {
      // Cost was paid.
      return [ResolveEventStateChange(event: this)];
    } else {
      // Exile summoning card.
      return [
        MoveCardStateChange(card: card, location: Location.exile),
        ResolveEventStateChange(event: this)
      ];
    }
  }

  /// Copy this event with the provided mana added.
  RequireManaEvent copyWithProvided(ManaAmount manaProvided) =>
      RequireManaEvent(
        cost: cost,
        provided: provided + manaProvided,
        card: card,
        resolved: resolved,
      );

  @override
  Event get copyResolved => RequireManaEvent(
      cost: cost, provided: provided, card: card, resolved: true);

  @override
  List<Object> get props => [cost, provided, card, resolved];
}
