import 'dart:collection';
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

  GameState({
    @required this.gameInfo,
    @required Iterable<CardObject> cards,
    @required Iterable<CardObject> stack,
    @required this.activePlayer,
    @required this.priorityPlayer,
    @required this.turnPhase,
  })  : cards = List<CardObject>.unmodifiable(cards),
        stack = List<CardObject>.unmodifiable(stack);
}
