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

class DamagePlayerEvent extends Event {
  final Player player;

  const DamagePlayerEvent({@required this.player});

  @override
  List<StateChange> apply(GameState state) {
    final deck = state.getCardsByLocation(player, Location.deck);
    if (deck.isEmpty) {
      return [
        GameOverStateChange(
            gameOverState: player == Player.one
                ? GameOverState.player2Win
                : GameOverState.player1Win),
        RemoveStackEventStateChange(event: this),
      ];
    } else {
      final card = (deck..shuffle()).first;
      return [
        MoveCardStateChange(card: card, location: Location.exile),
        RemoveStackEventStateChange(event: this),
      ];
    }
  }

  @override
  List<Object> get props => [player];
}
