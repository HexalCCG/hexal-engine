import 'package:hexal_engine/game_state/game_over_state.dart';
import 'package:hexal_engine/state_change/game_over_state_change.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:hexal_engine/state_change/remove_stack_event_state_change.dart';
import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../game_state/player.dart';
import '../state_change/state_change.dart';
import 'event.dart';

class DrawCardEvent extends Event {
  final Player player;

  const DrawCardEvent({@required this.player});

  @override
  List<StateChange> apply(GameState state) {
    final card = state.getTopCardOfDeck(player);
    if (card == null) {
      return [
        GameOverStateChange(
            gameOverState: player == Player.one
                ? GameOverState.player2Win
                : GameOverState.player1Win),
        RemoveStackEventStateChange(event: this),
      ];
    } else {
      return [
        MoveCardStateChange(card: card, location: Location.hand),
        RemoveStackEventStateChange(event: this),
      ];
    }
  }

  @override
  List<Object> get props => [player];
}
