import 'package:meta/meta.dart';
import 'objects/player_object.dart';

class GameInfo {
  final PlayerObject player1;
  final PlayerObject player2;

  const GameInfo({
    @required this.player1,
    @required this.player2,
  });
}
