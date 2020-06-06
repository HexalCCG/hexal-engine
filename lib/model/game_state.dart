import 'dart:collection';
import 'package:meta/meta.dart';

import 'card_object.dart';
import 'player.dart';
import 'turn_phase.dart';

@immutable
class GameState {
  final UnmodifiableListView<CardObject> cards;
  final UnmodifiableListView<CardObject> stack;
  final Player activePlayer;
  final Player priorityPlayer;
  final TurnPhase turnPhase;

  GameState({
    @required Iterable<CardObject> cards,
    @required Iterable<CardObject> stack,
    @required this.activePlayer,
    @required this.priorityPlayer,
    @required this.turnPhase,
  })  : cards = List<CardObject>.unmodifiable(cards),
        stack = List<CardObject>.unmodifiable(stack);
}
