import 'package:meta/meta.dart';

import '../game_state/game_over_state.dart';
import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../game_state/player.dart';
import '../state_change/game_over_state_change.dart';
import '../state_change/move_card_state_change.dart';
import '../state_change/remove_event_state_change.dart';
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
        RemoveEventStateChange(event: this),
      ];
    } else {
      return [
        MoveCardStateChange(card: card, location: Location.hand),
        RemoveEventStateChange(event: this),
      ];
    }
  }

  @override
  List<Object> get props => [player];
}
