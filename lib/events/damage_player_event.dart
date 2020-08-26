import 'package:hexal_engine/models/game_object.dart';
import 'package:hexal_engine/models/game_object_reference.dart';

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

/// Event dealing damage to a player.
class DamagePlayerEvent extends Event {
  /// Player to be damaged.
  final GameObject player;

  /// Damage to deal.
  final int damage;

  /// Which point of damage is currently being resolved.
  final int damageNumber;

  /// Deals [damage] damage to [player] one point at a time.
  const DamagePlayerEvent({
    required this.player,
    required this.damage,
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

  /// Create this event from json.
  factory DamagePlayerEvent.fromJson(List<dynamic> json) => DamagePlayerEvent(
      player: GameObjectReference.fromJson(json[0] as int),
      damage: json[1] as int,
      damageNumber: json[2] as int,
      resolved: json[3] as bool);
}
