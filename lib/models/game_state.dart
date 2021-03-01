import 'package:equatable/equatable.dart';

import '../actions/action.dart';
import '../events/event.dart';
import '../exceptions/game_state_exception.dart';
import '../state_changes/remove_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'card.dart';
import 'enums/event_state.dart';
import 'enums/game_over_state.dart';
import 'enums/location.dart';
import 'enums/player.dart';
import 'enums/turn_phase.dart';
import 'history.dart';

/// Represents a single moment snapshot of a game.
class GameState extends Equatable {
  /// The player whose turn it currently is.
  final Player activePlayer;

  /// The player who holds priority and can play cards.
  final Player priorityPlayer;

  /// Phase of the turn we are in.
  final TurnPhase turnPhase;

  /// All cards held in the state.
  final List<Card> cards;

  /// Stack of events resolved top-first.
  final List<Event> stack;

  /// Whether the game has ended.
  final GameOverState gameOverState;

  /// Whether a counter phase will occur this turn.
  final bool counterAvailable;

  /// Card events that occurred this turn.
  final History history;

  /// Next event id.
  final int nextEventId;

  /// Represents a single moment snapshot of a game.
  const GameState({
    required this.activePlayer,
    required this.priorityPlayer,
    required this.turnPhase,
    required this.cards,
    required this.stack,
    required this.history,
    this.gameOverState = GameOverState.playing,
    this.counterAvailable = false,
    this.nextEventId = 0,
  });

  // GETTERS

  /// Player without priorty.
  Player get notPriorityPlayer =>
      (priorityPlayer == Player.one) ? Player.two : Player.one;

  /// Player whose turn it isn't.
  Player get notActivePlayer =>
      (activePlayer == Player.one) ? Player.two : Player.one;

  /// Returns cards in the specified zone.
  List<Card> getCardsByLocation(Player player, Location location) {
    return cards
        .where((card) => card.controller == player && card.location == location)
        .toList();
  }

  /// Checks if a card with the provided id exists in the state.
  bool containsCardWithId(int id) => cards.any((card) => card.id == id);

  /// Gets a card from this state by its id.
  Card getCardById(int id) {
    if (id < 2) {
      throw const GameStateException('Cannot get card with player ID');
    }
    if (!containsCardWithId(id)) {
      throw const GameStateException('Card not found in state');
    }
    return cards.firstWhere((element) => element.id == id);
  }

  /// Gets this state's version of the provided event.
  Event getEvent(Event event) =>
      stack.firstWhere((element) => element == event);

  /// Get the top card of the provided player's deck.
  /// Returns null if deck is empty.
  Card? getTopCardOfDeck(Player player) {
    final deck = getCardsByLocation(player, Location.deck);
    if (deck.isEmpty) {
      return null;
    } else {
      return (deck..shuffle()).first;
    }
  }

  // MODIFICATION

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

  /// Attempts to resolve the top stack event.
  List<StateChange> resolveTopStackEvent() {
    // If the top event has been resolved, remove it and check for input again.
    if (stack.last.state != EventState.unresolved) {
      return [RemoveEventStateChange(event: stack.last)];
    }

    // If the top event still needs to be resolved, iterate it.
    return stack.last.apply(this);
  }

  // SERIALIZATION

  /// Create a GameState from its JSON encoding.
  GameState.fromJson(Map<String, dynamic> json)
      : activePlayer = Player.fromIndex(json['activePlayer'] as int),
        priorityPlayer = Player.fromIndex(json['priorityPlayer'] as int),
        turnPhase = TurnPhase.fromIndex(json['turnPhase'] as int),
        cards = (json['cards'] as List<dynamic>)
            .map((dynamic data) => Card.fromJson(data as Map<String, dynamic>))
            .toList(),
        stack = (json['stack'] as List<dynamic>)
            .map((dynamic data) => Event.fromJson(data as Map<String, dynamic>))
            .toList(),
        history = History.fromJson(json['history'] as List<dynamic>),
        gameOverState = GameOverState.fromIndex(json['gameOverState'] as int),
        counterAvailable = json['counterAvailable'] as bool,
        nextEventId = json['nextEventId'] as int;

  /// Encode this GameState as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'activePlayer': activePlayer.index,
        'priorityPlayer': priorityPlayer.index,
        'turnPhase': turnPhase.index,
        'cards': cards,
        'stack': stack,
        'history': history,
        'gameOverState': gameOverState.index,
        'counterAvailable': counterAvailable,
        'nextEventId': nextEventId,
      };

  /// Return a copy of this state with the provided fields replaced.
  GameState copyWith({
    Player? activePlayer,
    Player? priorityPlayer,
    TurnPhase? turnPhase,
    List<Card>? cards,
    List<Event>? stack,
    History? history,
    GameOverState? gameOverState,
    bool? counterAvailable,
    int? nextEventId,
  }) {
    return GameState(
      activePlayer: activePlayer ?? this.activePlayer,
      priorityPlayer: priorityPlayer ?? this.priorityPlayer,
      turnPhase: turnPhase ?? this.turnPhase,
      cards: cards ?? this.cards,
      stack: stack ?? this.stack,
      history: history ?? this.history,
      gameOverState: gameOverState ?? this.gameOverState,
      counterAvailable: counterAvailable ?? this.counterAvailable,
      nextEventId: nextEventId ?? this.nextEventId,
    );
  }

  @override
  String toString() => props.toString();

  @override
  List<Object> get props => [
        activePlayer,
        priorityPlayer,
        turnPhase,
        cards,
        stack,
        history,
        gameOverState,
        counterAvailable,
        nextEventId,
      ];
}
