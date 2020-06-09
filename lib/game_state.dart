import 'package:equatable/equatable.dart';
import 'package:hexal_engine/game_over_state.dart';
import 'package:meta/meta.dart';

import 'game_info.dart';
import 'objects/card_object.dart';
import 'objects/player_object.dart';
import 'turn_phase.dart';

class GameState extends Equatable {
  final GameInfo gameInfo;
  final GameOverState gameOverState;
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

  @literal
  const GameState({
    @required this.gameInfo,
    @required this.gameOverState,
    @required this.cards,
    @required this.stack,
    @required this.activePlayer,
    @required this.priorityPlayer,
    @required this.turnPhase,
  });

  GameState copyWith({
    GameInfo gameInfo,
    GameOverState gameOverState,
    List<CardObject> cards,
    List<CardObject> stack,
    PlayerObject activePlayer,
    PlayerObject priorityPlayer,
    TurnPhase turnPhase,
  }) {
    return GameState(
      gameInfo: gameInfo ?? this.gameInfo,
      gameOverState: gameOverState ?? this.gameOverState,
      cards: cards ?? this.cards,
      stack: stack ?? this.stack,
      activePlayer: activePlayer ?? this.activePlayer,
      priorityPlayer: priorityPlayer ?? this.priorityPlayer,
      turnPhase: turnPhase ?? this.turnPhase,
    );
  }

  @override
  List<Object> get props => [
        gameInfo,
        gameOverState,
        cards,
        stack,
        activePlayer,
        priorityPlayer,
        turnPhase
      ];
}
