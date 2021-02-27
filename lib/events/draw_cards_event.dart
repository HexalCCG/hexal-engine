import '../models/enums/game_over_state.dart';
import '../models/enums/location.dart';
import '../models/enums/player.dart';
import '../models/game_state.dart';
import '../state_changes/game_over_state_change.dart';
import '../state_changes/modify_event_state_change.dart';
import '../state_changes/move_card_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'event.dart';

/// Event that draws cards for a player.
class DrawCardsEvent extends Event {
  /// Player to draw.
  final Player player;

  /// Number of cards to draw.
  final int draws;

  /// Cards already drawn.
  final int cardsDrawn;

  /// [Player] draws [draws] cards, one at a time.
  const DrawCardsEvent({
    int id = 0,
    required this.player,
    required this.draws,
    this.cardsDrawn = 0,
  }) : super(id: id);

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
      final _reference = _card.id;
      return [
        MoveCardStateChange(card: _reference, location: Location.hand),
      ];
    }
  }

  DrawCardsEvent get _copyIncremented => DrawCardsEvent(
        id: id,
        player: player,
        draws: draws,
        cardsDrawn: cardsDrawn + 1,
      );

  @override
  DrawCardsEvent copyWithId(int id) => DrawCardsEvent(
        id: id,
        player: player,
        draws: draws,
        cardsDrawn: cardsDrawn,
      );

  @override
  List<Object> get props => [id, player, draws, cardsDrawn];

  /// Create this event from json
  static DrawCardsEvent fromJson(List<dynamic> json) => DrawCardsEvent(
        id: json[0] as int,
        player: Player.fromIndex(json[1] as int),
        draws: json[2] as int,
        cardsDrawn: json[3] as int,
      );
}
