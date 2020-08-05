import 'package:equatable/equatable.dart';
import 'package:hexal_engine/actions/pass_action.dart';
import 'package:hexal_engine/exceptions/game_state_exception.dart';
import 'package:hexal_engine/objects/player_object.dart';
import 'package:hexal_engine/state_change/remove_event_state_change.dart';
import 'package:meta/meta.dart';

import '../actions/action.dart';
import '../event/event.dart';
import '../objects/card_object.dart';
import '../state_change/state_change.dart';
import 'game_over_state.dart';
import 'location.dart';
import 'player.dart';
import 'turn_phase.dart';

/// GameStates represent a single moment snapshot of a game.
@immutable
class GameState extends Equatable {
  final Player activePlayer;
  final Player priorityPlayer;
  final TurnPhase turnPhase;
  final List<CardObject> cards;
  final List<Event> stack;
  final GameOverState gameOverState;
  final bool counterAvailable;

  Player get notPriorityPlayer =>
      (priorityPlayer == Player.one) ? Player.two : Player.one;
  Player get notActivePlayer =>
      (activePlayer == Player.one) ? Player.two : Player.one;

  const GameState({
    @required this.activePlayer,
    @required this.priorityPlayer,
    @required this.turnPhase,
    @required this.cards,
    @required this.stack,
    this.gameOverState = GameOverState.playing,
    this.counterAvailable = false,
  });

  const GameState.startingState({
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
  GameState applyAction(Action action) {
    if (gameOverState != GameOverState.playing) {
      throw GameStateException(
          'GameState Exception: Game is over: ' + gameOverState.toString());
    }
    return applyStateChanges(generateStateChanges(action));
  }

  /// Test only - submits pass actions until the stack is empty.
  GameState testPassUntilEmpty() {
    var state = this;
    while (state.stack.isNotEmpty) {
      state = state.applyAction(PassAction());
    }
    return state;
  }

  /// Attempts to resolve the top stack event.
  List<StateChange> resolveTopStackEvent() {
    /*
    // If the top event has been resolved, remove it and repeat.
    if (stack.last.resolved) {
      return [
        RemoveEventStateChange(event: stack.last),
        ...applyStateChanges([RemoveEventStateChange(event: stack.last)])
            .resolveTopStackEvent(),
      ];
    }
    */
    // If the top event has been resolved, remove it and check for input again.
    if (stack.last.resolved) {
      return [RemoveEventStateChange(event: stack.last)];
    }
    // If the top event still needs to be resolved, iterate it.
    return stack.last.apply(this);
  }

  /// Returns cards in the specified zone.
  List<CardObject> getCardsByLocation(Player player, Location location) {
    return cards
        .where((card) => card.controller == player && card.location == location)
        .toList();
  }

  // Gets this state's version of the provided card.
  CardObject getCard(CardObject card) =>
      cards.firstWhere((element) => element == card);

  // Gets this state's version of the provided event.
  Event getEvent(Event event) =>
      stack.firstWhere((element) => element == event);

  // Return the playerobject for a player
  PlayerObject getPlayerObject(Player player) => player == Player.one
      ? const PlayerObject(id: 0, player: Player.one)
      : const PlayerObject(id: 1, player: Player.two);

  CardObject getTopCardOfDeck(Player player) {
    final deck = getCardsByLocation(player, Location.deck);
    if (deck.isEmpty) {
      return null;
    } else {
      return (deck..shuffle()).first;
    }
  }

  GameState copyWith({
    Player activePlayer,
    Player priorityPlayer,
    TurnPhase turnPhase,
    List<CardObject> cards,
    List<Event> stack,
    GameOverState gameOverState,
    bool counterAvailable,
  }) {
    return GameState(
      activePlayer: activePlayer ?? this.activePlayer,
      priorityPlayer: priorityPlayer ?? this.priorityPlayer,
      turnPhase: turnPhase ?? this.turnPhase,
      cards: cards ?? this.cards,
      stack: stack ?? this.stack,
      gameOverState: gameOverState ?? this.gameOverState,
      counterAvailable: counterAvailable ?? this.counterAvailable,
    );
  }

  @override
  List<Object> get props => [
        activePlayer,
        priorityPlayer,
        turnPhase,
        cards,
        stack,
        gameOverState,
        counterAvailable,
      ];

  /// Override toString to fix equatable stringify missing some props.
  @override
  String toString() => props.toString();
}
