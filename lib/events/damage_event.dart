import '../models/enums/player.dart';
import '../models/game_object_reference.dart';
import 'damage_creature_event.dart';
import 'damage_player_event.dart';
import 'event.dart';

/// Event that damages a creature or a player.
abstract class DamageEvent extends Event {
  /// Event that damages a creature or a player.
  factory DamageEvent(
      {required GameObjectReference target, required int damage}) {
    if (target.id < 2) {
      return DamagePlayerEvent(
          player: Player.fromIndex(target.id), damage: damage);
    } else {
      return DamageCreatureEvent(creature: target, damage: damage);
    }
  }
}
