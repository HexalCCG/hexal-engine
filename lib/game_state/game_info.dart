import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../objects/player_object.dart';
import 'player.dart';

class GameInfo extends Equatable {
  final PlayerObject player1;
  final PlayerObject player2;

  const GameInfo({
    @required this.player1,
    @required this.player2,
  });

  PlayerObject getPlayerObject(Player player) =>
      player == Player.one ? player1 : player2;

  @override
  List<Object> get props => [player1, player2];
}
