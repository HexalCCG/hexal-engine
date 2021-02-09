import 'package:equatable/equatable.dart';

import '../actions/action.dart';
import '../actions/attack_action.dart';
import '../actions/attack_player_action.dart';
import '../actions/pass_action.dart';
import '../actions/play_card_action.dart';
import '../events/event.dart';
import '../exceptions/game_state_exception.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/remove_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'card.dart';
import 'enums/game_over_state.dart';
import 'enums/location.dart';
import 'enums/player.dart';
import 'enums/turn_phase.dart';
import 'game_object.dart';
import 'player_object.dart';

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
      throw GameStateException('Cannot get card with player ID');
    }
    if (!containsCardWithId(id)) {
      throw GameStateException('Card not found in state');
    }
    return cards.firstWhere((element) => element.id == id);
  }

  /// Gets a game object from this state by its id.
  GameObject getGameObjectById(int id) {
    if (id == 0) {
      return PlayerObject(player: Player.one);
    } else if (id == 1) {
      return PlayerObject(player: Player.two);
    } else {
      return getCardById(id);
    }
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

  /// Get a list of all possible actions for this state.
  List<Action> get allActions {
    final list = <Action>[];
    // Pass action
    list.add(PassAction());
    // Attack action
    for (var attacker in getCardsByLocation(priorityPlayer, Location.field)) {
      final attackerReference = attacker.toReference;
      for (var defender
          in getCardsByLocation(notPriorityPlayer, Location.field)) {
        list.add(AttackAction(
            attacker: attackerReference, defender: defender.toReference));
      }
    }
    // Attack player action
    for (var attacker in getCardsByLocation(priorityPlayer, Location.field)) {
      list.add(AttackPlayerAction(
          attacker: attacker.toReference, player: notPriorityPlayer));
    }
    // Play card action
    for (var card in getCardsByLocation(priorityPlayer, Location.hand)) {
      list.add(PlayCardAction(card: card.toReference));
    }
    return list;
  }

  /// Get a list of possible actions filtered by validity.
  List<Action> get validActions {
    return allActions.where((action) => action.valid(this)).toList();
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

  /// Generates then applies state changes for provided event.
  GameState addAndResolveEvent(Event event) {
    var state = applyStateChanges([AddEventStateChange(event: event)]);
    return state.applyStateChanges(state.resolveTopStackEvent());
  }

  /// Attempts to resolve the top stack event.
  List<StateChange> resolveTopStackEvent() {
    // If the top event has been resolved, remove it and check for input again.
    if (stack.last.resolved) {
      return [RemoveEventStateChange(event: stack.last)];
    }
    // If the top event still needs to be resolved, iterate it.
    return stack.last.apply(this);
  }

  // TEST ONLY

  /// Test only - submits pass actions until the stack is empty.
  GameState testPassUntilEmpty() {
    var state = this;
    while (state.stack.isNotEmpty) {
      state = state.applyAction(PassAction());
    }
    return state;
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
        gameOverState = GameOverState.fromIndex(json['gameOverState'] as int),
        counterAvailable = json['counterAvailable'] as bool;

  /// Encode this GameState as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'activePlayer': activePlayer.index,
        'priorityPlayer': priorityPlayer.index,
        'turnPhase': turnPhase.index,
        'cards': cards,
        'stack': stack,
        'gameOverState': gameOverState.index,
        'counterAvailable': counterAvailable,
      };

  /// Return a copy of this state with the provided fields replaced.
  GameState copyWith({
    Player? activePlayer,
    Player? priorityPlayer,
    TurnPhase? turnPhase,
    List<Card>? cards,
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
  String toString() => props.toString();

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
}
