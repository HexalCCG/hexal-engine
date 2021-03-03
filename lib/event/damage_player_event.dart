import '../model/enums/event_state.dart';
import '../model/enums/game_over_state.dart';
import '../model/enums/location.dart';
import '../model/enums/player.dart';
import '../model/game_state.dart';
import '../state_change/game_over_state_change.dart';
import '../state_change/modify_event_state_change.dart';
import '../state_change/move_card_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
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

  /// Deals [damage] damage to [player] one point at a time.
  const DamagePlayerEvent({
    int id = 0,
    EventState state = EventState.unresolved,
    required this.player,
    required this.damage,
    this.damageDealt = 0,
  }) : super(id: id, state: state);

  @override
  bool valid(GameState state) {
    if (damageDealt >= damage) return false;
    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      return [
        ResolveEventStateChange(event: this, eventState: EventState.failed)
      ];
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
        ResolveEventStateChange(event: this, eventState: EventState.succeeded),
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
      final _reference = _card.id;

      return [
        MoveCardStateChange(card: _reference, location: Location.exile),
      ];
    }
  }

  DamagePlayerEvent get _copyIncremented => DamagePlayerEvent(
        id: id,
        player: player,
        damage: damage,
        damageDealt: damageDealt + 1,
      );

  @override
  DamagePlayerEvent copyWith({int? id, EventState? state}) => DamagePlayerEvent(
        id: id ?? this.id,
        state: state ?? this.state,
        player: player,
        damage: damage,
        damageDealt: damageDealt,
      );

  @override
  List<Object> get props => [id, state, player, damage, damageDealt];

  /// Create this event from json.
  static DamagePlayerEvent fromJson(List<dynamic> json) => DamagePlayerEvent(
        id: json[0] as int,
        state: EventState.fromIndex(json[1] as int),
        player: Player.fromIndex(json[2] as int),
        damage: json[3] as int,
        damageDealt: json[4] as int,
      );
}
