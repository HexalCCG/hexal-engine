import '../game_state/player.dart';
import 'game_object.dart';
import 'package:meta/meta.dart';

class PlayerObject extends GameObject {
  final Player player;

  const PlayerObject({@required this.player});

  @override
  int get id => player.index;

  @override
  List<Object> get toStringProps => [player];
}
