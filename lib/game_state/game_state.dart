import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../actions/action.dart';
import '../event/event.dart';
import '../objects/card_object.dart';
import '../state_change/remove_stack_event_state_change.dart';
import '../state_change/state_change.dart';
import 'game_info.dart';
import 'game_over_state.dart';
import 'player.dart';
import 'turn_phase.dart';

class GameState extends Equatable {
  final GameInfo gameInfo;
  final GameOverState gameOverState;
  final List<Event> stack;
  final List<CardObject> cards;
  final Player activePlayer;
  final Player priorityPlayer;
  final TurnPhase turnPhase;

  final List<CardObject> p1DeckOrder;
  final List<CardObject> p2DeckOrder;

  Player get notPriorityPlayer =>
      (priorityPlayer == Player.one) ? Player.two : Player.one;
  Player get notActivePlayer =>
      (activePlayer == Player.one) ? Player.two : Player.one;

  const GameState({
    @required this.gameInfo,
    @required this.gameOverState,
    @required this.cards,
    @required this.stack,
    @required this.activePlayer,
    @required this.priorityPlayer,
    @required this.turnPhase,
    @required this.p1DeckOrder,
    @required this.p2DeckOrder,
  });

  const GameState.startingState({
    @required this.gameInfo,
    bool player1Starts,
  })  : gameOverState = GameOverState.playing,
        cards = const [],
        stack = const [],
        activePlayer = player1Starts ? Player.one : Player.two,
        priorityPlayer = player1Starts ? Player.one : Player.two,
        turnPhase = TurnPhase.start,
        p1DeckOrder = const [],
        p2DeckOrder = const [];

  List<StateChange> applyAction(Action action) => action.apply(this);

  GameState applyStateChanges(List<StateChange> changes) =>
      changes.fold(this, (currentState, change) => change.apply(currentState));

  List<StateChange> resolveTopStackEvent() => stack.last.apply(this)
    ..add(RemoveStackEventStateChange(event: stack.last));

  GameState copyWith({
    GameInfo gameInfo,
    GameOverState gameOverState,
    List<CardObject> cards,
    List<Event> stack,
    Player activePlayer,
    Player priorityPlayer,
    TurnPhase turnPhase,
    List<CardObject> p1DeckOrder,
    List<CardObject> p2DeckOrder,
  }) {
    return GameState(
      gameInfo: gameInfo ?? this.gameInfo,
      gameOverState: gameOverState ?? this.gameOverState,
      cards: cards ?? this.cards,
      stack: stack ?? this.stack,
      activePlayer: activePlayer ?? this.activePlayer,
      priorityPlayer: priorityPlayer ?? this.priorityPlayer,
      turnPhase: turnPhase ?? this.turnPhase,
      p1DeckOrder: p1DeckOrder ?? this.p1DeckOrder,
      p2DeckOrder: p2DeckOrder ?? this.p2DeckOrder,
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
        turnPhase,
        p1DeckOrder,
        p2DeckOrder,
      ];
}
