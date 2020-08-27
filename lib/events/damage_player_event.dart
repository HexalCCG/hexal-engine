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
import 'damage_event.dart';
import 'event.dart';

/// Event dealing damage to a player.
class DamagePlayerEvent extends Event implements DamageEvent {
  /// Player to be damaged.
  final Player player;

  /// Damage to deal.
  final int damage;

  /// Which point of damage is currently being resolved.
  final int damageDealt;

  @override
  final bool resolved;

  /// Deals [damage] damage to [player] one point at a time.
  const DamagePlayerEvent({
    required this.player,
    required this.damage,
    this.damageDealt = 0,
    this.resolved = false,
  });

  @override
  bool valid(GameState state) {
    if (damageDealt >= damage) return false;
    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      return [ResolveEventStateChange(event: this)];
    }

    if (damageDealt < damage - 1) {
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
      final _card = (deck..shuffle()).first;
      final _reference = GameObjectReference(id: _card.id);

      return [
        MoveCardStateChange(card: _reference, location: Location.exile),
      ];
    }
  }

  DamagePlayerEvent get _copyIncremented => DamagePlayerEvent(
        player: player,
        damage: damage,
        damageDealt: damageDealt + 1,
        resolved: resolved,
      );

  @override
  DamagePlayerEvent get copyResolved => DamagePlayerEvent(
        player: player,
        damage: damage,
        damageDealt: damageDealt,
        resolved: true,
      );

  @override
  List<Object> get props => [player, damage, damageDealt, resolved];

  /// Create this event from json.
  static DamagePlayerEvent fromJson(List<dynamic> json) => DamagePlayerEvent(
      player: Player.fromIndex(json[0] as int),
      damage: json[1] as int,
      damageDealt: json[2] as int,
      resolved: json[3] as bool);
}
