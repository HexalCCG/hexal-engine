import 'package:meta/meta.dart';

import '../cards/creature.dart';
import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../game_state/player.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'damage_player_event.dart';
import 'event.dart';

class AttackPlayerEvent extends Event {
  final Creature attacker;
  final Player player;

  const AttackPlayerEvent(
      {@required this.attacker, @required this.player, bool resolved = false})
      : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    if (attacker.location != Location.battlefield) {
      return [ResolveEventStateChange(event: this)];
    } else {
      return [
        AddEventStateChange(
            event: DamagePlayerEvent(player: player, damage: attacker.attack)),
        ResolveEventStateChange(event: this),
      ];
    }
  }

  @override
  AttackPlayerEvent get copyResolved =>
      AttackPlayerEvent(attacker: attacker, player: player, resolved: true);

  @override
  List<Object> get props => [attacker, player, resolved];
}
