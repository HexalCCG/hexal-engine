import 'package:meta/meta.dart';

import '../actions/action.dart';
import '../actions/pass_action.dart';
import '../event/event.dart';
import '../extensions/equatable/equatable.dart';
import '../objects/card_object.dart';
import '../objects/player_object.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/remove_event_state_change.dart';
import '../state_change/state_change.dart';
import 'game_over_state.dart';
import 'location.dart';
import 'player.dart';
import 'turn_phase.dart';

/// Represents a single moment snapshot of a game.
@immutable
class GameState extends Equatable {
  /// The player whose turn it currently is.
  final Player activePlayer;

  /// The player who holds priority and can play cards.
  final Player priorityPlayer;

  /// Phase of the turn we are in.
  final TurnPhase turnPhase;

  /// All cards held in the state.
  final List<CardObject> cards;

  /// Stack of events resolved top-first.
  final List<Event> stack;

  /// Whether the game has ended.
  final GameOverState gameOverState;

  /// Whether a counter phase will occur this turn.
  final bool counterAvailable;

  /// Player without priorty.
  Player get notPriorityPlayer =>
      (priorityPlayer == Player.one) ? Player.two : Player.one;

  /// Player whose turn it isn't.
  Player get notActivePlayer =>
      (activePlayer == Player.one) ? Player.two : Player.one;

  /// Represents a single moment snapshot of a game.
  const GameState({
    required this.activePlayer,
    required this.priorityPlayer,
    required this.turnPhase,
    required this.cards,
    required this.stack,
    this.gameOverState = GameOverState.playing,
    this.counterAvailable = false,
  });

  /// Returns state changes caused by the provided action.
  List<StateChange> generateStateChanges(Action action) => action.apply(this);

  /// Returns GameState created by the specified state changes.
  GameState applyStateChanges(List<StateChange> changes) =>
      changes.fold(this, (currentState, change) => change.apply(currentState));

  /// Generates then applies state changes for provided action.
  GameState applyAction(Action action) {
    assert(gameOverState == GameOverState.playing);
    return applyStateChanges(generateStateChanges(action));
  }

  /// Generates then applies state changes for provided event.
  GameState addAndResolveEvent(Event event) {
    var state = applyStateChanges([AddEventStateChange(event: event)]);
    return state.applyStateChanges(state.resolveTopStackEvent());
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

  /// Gets this state's version of the provided card.
  CardObject getCard(CardObject card) =>
      cards.firstWhere((element) => element == card);

  /// Gets this state's version of the provided event.
  Event getEvent(Event event) =>
      stack.firstWhere((element) => element == event);

  /// Return the playerobject for a player
  PlayerObject getPlayerObject(Player player) => player == Player.one
      ? const PlayerObject(id: 0, player: Player.one)
      : const PlayerObject(id: 1, player: Player.two);

  /// Get the top card of the provided player's deck.
  /// Returns null if deck is empty.
  CardObject? getTopCardOfDeck(Player player) {
    final deck = getCardsByLocation(player, Location.deck);
    if (deck.isEmpty) {
      return null;
    } else {
      return (deck..shuffle()).first;
    }
  }

  /// Return a copy of this state with the provided fields replaced.
  GameState copyWith({
    Player? activePlayer,
    Player? priorityPlayer,
    TurnPhase? turnPhase,
    List<CardObject>? cards,
    List<Event>? stack,
    GameOverState? gameOverState,
    bool? counterAvailable,
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
