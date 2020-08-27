import '../models/enums/game_over_state.dart';
import '../models/enums/location.dart';
import '../models/enums/player.dart';
import '../models/game_object_reference.dart';
import '../models/game_state.dart';
import '../state_changes/game_over_state_change.dart';
import '../state_changes/modify_event_state_change.dart';
import '../state_changes/move_card_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'event.dart';

/// Event that draws cards for a player.
class DrawCardEvent extends Event {
  /// Player to draw.
  final Player player;

  /// Number of cards to draw.
  final int draws;

  /// Cards already drawn.
  final int cardsDrawn;

  @override
  final bool resolved;

  /// [Player] draws [draws] cards, one at a time.
  const DrawCardEvent({
    required this.player,
    required this.draws,
    this.cardsDrawn = 0,
    this.resolved = false,
  });

  @override
  bool valid(GameState state) {
    if (cardsDrawn >= draws) return false;
    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      return [ResolveEventStateChange(event: this)];
    }

    if (cardsDrawn < draws - 1) {
      // If this isn't the last draw.
      return [
        ..._drawOnce(state),
        ModifyEventStateChange(event: this, newEvent: _copyIncremented),
      ];
    } else {
      // Deal the last point of damage and resolve.
      return [
        ..._drawOnce(state),
        ResolveEventStateChange(event: this),
      ];
    }
  }

  List<StateChange> _drawOnce(GameState state) {
    final _deck = state.getCardsByLocation(player, Location.deck);

    if (_deck.isEmpty) {
      return [
        GameOverStateChange(
            gameOverState: player == Player.one
                ? GameOverState.player2Win
                : GameOverState.player1Win),
      ];
    } else {
      final _card = (_deck..shuffle()).first;
      final _reference = GameObjectReference(id: _card.id);
      return [
        MoveCardStateChange(card: _reference, location: Location.hand),
      ];
    }
  }

  DrawCardEvent get _copyIncremented => DrawCardEvent(
        player: player,
        draws: draws,
        cardsDrawn: cardsDrawn + 1,
        resolved: resolved,
      );

  @override
  DrawCardEvent get copyResolved => DrawCardEvent(
      player: player, draws: draws, cardsDrawn: cardsDrawn, resolved: true);

  @override
  List<Object> get props => [player, draws, cardsDrawn, resolved];

  factory DrawCardEvent.fromJson(List<dynamic> json) => DrawCardEvent(
      player: Player.fromIndex(json[0] as int),
      draws: json[1] as int,
      cardsDrawn: json[2] as int,
      resolved: json[3] as bool);
}
