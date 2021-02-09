import '../models/enums/player.dart';
import 'damage_creature_event.dart';
import 'damage_player_event.dart';
import 'event.dart';

/// Event that damages a creature or a player.
abstract class DamageEvent extends Event {
  /// Event that damages a creature or a player.
  factory DamageEvent({required int target, required int damage}) {
    if (target < 2) {
      return DamagePlayerEvent(
          player: Player.fromIndex(target), damage: damage);
    } else {
      return DamageCreatureEvent(creature: target, damage: damage);
    }
  }
}
