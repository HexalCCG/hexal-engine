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

class DamagePlayerEvent extends Event {
  final Player player;
  final int damage;
  final int damageNumber;

  const DamagePlayerEvent({
    @required this.player,
    @required this.damage,
    this.damageNumber = 1,
    bool resolved = false,
  }) : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    if (damageNumber < damage) {
      // If this isn't the last damage.
      return [
        ..._dealDamage(state),
        ModifyEventStateChange(event: this, newEvent: _copyIncremented),
      ];
    } else {
      // Deal the last point of damage and resolve.
      return [
        ..._dealDamage(state),
        ResolveEventStateChange(event: this),
      ];
    }
  }

  List<StateChange> _dealDamage(GameState state) {
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
        MoveCardStateChange(card: card, location: Location.exile),
      ];
    }
  }

  DamagePlayerEvent get _copyIncremented => DamagePlayerEvent(
        player: player,
        damage: damage,
        damageNumber: damageNumber + 1,
        resolved: resolved,
      );

  @override
  DamagePlayerEvent get copyResolved => DamagePlayerEvent(
        player: player,
        damage: damage,
        damageNumber: damageNumber,
        resolved: true,
      );

  @override
  List<Object> get props => [player, damage, damageNumber, resolved];
}
