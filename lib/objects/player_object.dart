import '../game_state/player.dart';
import 'game_object.dart';
import 'package:meta/meta.dart';

class PlayerObject extends GameObject {
  final Player player;

  const PlayerObject({@required int id, @required this.player}) : super(id: id);

  @override
  List<Object> get toStringProps => [id, player];
}
