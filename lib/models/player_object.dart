import 'package:hexal_engine/exceptions/game_object_exception.dart';

import '../models/player.dart';
import 'game_object.dart';

/// GameObject to represent a player for targeting.
class PlayerObject extends GameObject {
  /// Which player this object represents.
  final Player player;

  /// Represents one of the players.
  /// [id] should be 0 for Player One, and 1 for Player Two.
  const PlayerObject({required this.player})
      : super(id: player == Player.one ? 0 : 1);

  @override
  GameObject copyWith(Map<String, dynamic> changes) =>
      PlayerObject(player: changes['player'] as Player? ?? player);

  @override
  List<Object> get props => [player];
}
