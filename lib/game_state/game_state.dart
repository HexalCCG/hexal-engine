import 'package:equatable/equatable.dart';
import 'package:hexal_engine/exceptions/game_state_exception.dart';
import 'package:hexal_engine/state_change/increment_stack_event_state_change.dart';
import 'package:meta/meta.dart';

import '../actions/action.dart';
import '../event/event.dart';
import '../objects/card_object.dart';
import '../state_change/remove_stack_event_state_change.dart';
import '../state_change/state_change.dart';
import 'game_info.dart';
import 'game_over_state.dart';
import 'location.dart';
import 'player.dart';
import 'turn_phase.dart';

/// GameStates represent a single moment snapshot of a game.
@immutable
class GameState extends Equatable {
  final GameInfo gameInfo;
  final GameOverState gameOverState;
  final List<CardObject> cards;
  final List<Event> stack;
  final Player activePlayer;
  final Player priorityPlayer;
  final TurnPhase turnPhase;

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
  });

  const GameState.startingState({
    @required this.gameInfo,
    bool player1Starts,
  })  : gameOverState = GameOverState.playing,
        cards = const [],
        stack = const [],
        activePlayer = player1Starts ? Player.one : Player.two,
        priorityPlayer = player1Starts ? Player.one : Player.two,
        turnPhase = TurnPhase.start;

  /// Returns state changes caused by the provided action.
  List<StateChange> generateStateChanges(Action action) => action.apply(this);

  /// Returns GameState created by the specified state changes.
  GameState applyStateChanges(List<StateChange> changes) =>
      changes.fold(this, (currentState, change) => change.apply(currentState));

  /// Generates then applies state changes for provided action.
  GameState applyAction(Action action) =>
      applyStateChanges(generateStateChanges(action));

  /// Attempts to resolve the top stack event.
  List<StateChange> resolveTopStackEvent() {
    final list = stack.last.apply(this);

    // Check for infinite loops
    // TODO: Remove in release
    if (!list.any((element) =>
        element is RemoveStackEventStateChange ||
        element is IncrementStackEventStateChange)) {
      throw GameStateException('Probable infinite loop: no card ');
    } else {
      return list;
    }
  }

  /// Returns cards in the specified zone.
  List<CardObject> getCardsByLocation(Player player, Location location) {
    return cards
        .where((card) => card.controller == player && card.location == location)
        .toList();
  }

  CardObject getTopCardOfDeck(Player player) {
    final deck = getCardsByLocation(player, Location.deck);
    if (deck.isEmpty) {
      return null;
    } else {
      return (deck..shuffle()).first;
    }
  }

  GameState copyWith({
    GameInfo gameInfo,
    GameOverState gameOverState,
    List<CardObject> cards,
    List<Event> stack,
    Player activePlayer,
    Player priorityPlayer,
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
        turnPhase,
      ];

  /// Override toString to fix equatable stringify missing some props.
  @override
  String toString() => props.toString();
}
