import 'package:meta/meta.dart';

import 'game_info.dart';
import 'objects/card_object.dart';
import 'objects/player_object.dart';
import 'turn_phase.dart';

@immutable
class GameState {
  final GameInfo gameInfo;
  final List<CardObject> cards;
  final List<CardObject> stack;
  final PlayerObject activePlayer;
  final PlayerObject priorityPlayer;
  final TurnPhase turnPhase;

  PlayerObject get notPriorityPlayer => (priorityPlayer == gameInfo.player1)
      ? gameInfo.player2
      : gameInfo.player1;
  PlayerObject get notActivePlayer =>
      (activePlayer == gameInfo.player1) ? gameInfo.player2 : gameInfo.player1;

  const GameState({
    @required this.gameInfo,
    @required this.cards,
    @required this.stack,
    @required this.activePlayer,
    @required this.priorityPlayer,
    @required this.turnPhase,
  });
}
