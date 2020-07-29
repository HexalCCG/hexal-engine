import 'package:hexal_engine/state_change/modify_event_state_change.dart';
import 'package:meta/meta.dart';

import '../game_state/game_over_state.dart';
import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../game_state/player.dart';
import '../state_change/game_over_state_change.dart';
import '../state_change/move_card_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'event.dart';

class DrawCardEvent extends Event {
  final Player player;
  final int draws;
  final int drawNumber;

  const DrawCardEvent({
    @required this.player,
    @required this.draws,
    this.drawNumber = 1,
    bool resolved = false,
  }) : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    if (drawNumber < draws) {
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
    final deck = state.getCardsByLocation(player, Location.deck);
    if (deck.isEmpty) {
      return [
        GameOverStateChange(
            gameOverState: player == Player.one
                ? GameOverState.player2Win
                : GameOverState.player1Win),
      ];
    } else {
      final card = (deck..shuffle()).first;
      return [
        MoveCardStateChange(card: card, location: Location.hand),
      ];
    }
  }

  DrawCardEvent get _copyIncremented => DrawCardEvent(
        player: player,
        draws: draws,
        drawNumber: drawNumber + 1,
        resolved: resolved,
      );

  @override
  DrawCardEvent get copyResolved => DrawCardEvent(
      player: player, draws: draws, drawNumber: drawNumber, resolved: true);

  @override
  List<Object> get props => [player, draws, drawNumber, resolved];
}
