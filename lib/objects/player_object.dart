import '../game_state/player.dart';
import 'game_object.dart';

/// GameObject to represent a player for targeting.
class PlayerObject extends GameObject {
  /// Which player this object represents.
  final Player player;

  /// Represents one of the players.
  /// [id] should be 0 for Player One, and 1 for Player Two.
  const PlayerObject({required int id, required this.player}) : super(id: id);

  @override
  List<Object> get toStringProps => [id, player];
}
