import '../card/creature.dart';
import '../models/enums/location.dart';
import '../models/enums/player.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/set_counter_available_state_change.dart';
import '../state_changes/state_change.dart';
import 'damage_player_event.dart';
import 'event.dart';

/// Event for a creature attacking a player.
class AttackPlayerEvent extends Event {
  /// Creature attacking.
  final int attacker;

  /// Player being attacked.
  final Player player;

  /// Should this enable counterattacks this turn?
  final bool enableCounter;

  /// [attacker] attacks [player]. Exhausts attacker if [exhaustAttacker].
  /// Enables counterattacks this turn if [enableCounter].
  const AttackPlayerEvent({
    int id = 0,
    required this.attacker,
    required this.player,
    this.enableCounter = true,
  }) : super(id: id);

  @override
  bool valid(GameState state) {
    final _attacker = state.getCardById(attacker);

    // Check if attacker is valid
    if (!(_attacker is Creature) || _attacker.location != Location.field) {
      return false;
    }

    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      return [ResolveEventStateChange(event: this)];
    }

    // Casts safe because of valid check above.
    final _attacker = state.getCardById(attacker) as Creature;
    final _player = Player.fromIndex(player.index);

    return [
      AddEventStateChange(
          event: DamagePlayerEvent(player: _player, damage: _attacker.attack)),
      ...enableCounter
          ? [const SetCounterAvailableStateChange(enabled: true)]
          : [],
      ResolveEventStateChange(event: this),
    ];
  }

  @override
  AttackPlayerEvent copyWithId(int id) => AttackPlayerEvent(
        id: id,
        attacker: attacker,
        player: player,
        enableCounter: enableCounter,
      );

  @override
  List<Object> get props => [id, attacker, player, enableCounter];

  /// Create this event from json.
  static AttackPlayerEvent fromJson(List<dynamic> json) => AttackPlayerEvent(
        id: json[0] as int,
        attacker: json[1] as int,
        player: Player.fromIndex(json[2] as int),
        enableCounter: json[3] as bool,
      );
}
