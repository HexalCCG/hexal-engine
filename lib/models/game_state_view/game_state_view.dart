import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../actions/action.dart';
import '../../events/event.dart';
import '../enums/game_over_state.dart';
import '../enums/location.dart';
import '../enums/player.dart';
import '../enums/turn_phase.dart';
import '../game_state.dart';
import 'card_object_view.dart';

/// Immutable view of a game state.
@immutable
class GameStateView extends Equatable {
  /// Which player the viewing client is.
  final Player? clientPlayer;

  /// The player whose turn it currently is.
  final Player activePlayer;

  /// The player who holds priority and can play cards.
  final Player priorityPlayer;

  /// Phase of the turn we are in.
  final TurnPhase turnPhase;

  /// All cards held in the state.
  final List<CardObjectView> cards;

  /// Stack of events resolved top-first.
  final List<Event> stack;

  /// Whether the game has ended.
  final GameOverState gameOverState;

  /// Whether a counter phase will occur this turn.
  final bool counterAvailable;

  /// Represents a single moment snapshot of a game.
  const GameStateView({
    this.clientPlayer,
    required this.activePlayer,
    required this.priorityPlayer,
    required this.turnPhase,
    required this.cards,
    required this.stack,
    required this.gameOverState,
    required this.counterAvailable,
  });

  /// Create a view of a game state.
  GameStateView.fromGameState(GameState gameState,
      {bool showHidden = false, Player? viewer})
      : clientPlayer = viewer,
        activePlayer = gameState.activePlayer,
        priorityPlayer = gameState.priorityPlayer,
        turnPhase = gameState.turnPhase,
        cards = showHidden
            ? gameState.cards
                .map((cardObject) => CardObjectView.fromCardObject(cardObject))
                .toList()
            : gameState.cards
                .map((cardObject) => CardObjectView.fromCardObject(cardObject))
                .map((cardObjectView) =>
                    (cardObjectView.location == Location.hand &&
                                cardObjectView.controller != viewer) ||
                            cardObjectView.location == Location.deck
                        ? cardObjectView.hiddenView
                        : cardObjectView)
                .toList(),
        stack = gameState.stack,
        gameOverState = gameState.gameOverState,
        counterAvailable = gameState.counterAvailable;

  /// Returns an estimate of this view as a game state. Unknown cards are
  /// replaced with empty card representations.
  GameState get asGameState {
    return GameState(
      activePlayer: activePlayer,
      priorityPlayer: priorityPlayer,
      turnPhase: turnPhase,
      gameOverState: gameOverState,
      counterAvailable: counterAvailable,
      stack: stack,
      cards:
          cards.map((cardObjectView) => cardObjectView.asCardObject).toList(),
    );
  }

  /// Checks whether an action is valid on the current state.
  bool actionValid(Action action) {
    return action.valid(asGameState);
  }

  // GETTERS

  /// Player without priorty.
  Player get notPriorityPlayer =>
      (priorityPlayer == Player.one) ? Player.two : Player.one;

  /// Player whose turn it isn't.
  Player get notActivePlayer =>
      (activePlayer == Player.one) ? Player.two : Player.one;

  /// Returns cards in the specified zone.
  List<CardObjectView> getCardsByLocation(Player player, Location location) {
    return cards
        .where((card) => card.controller == player && card.location == location)
        .toList();
  }

  // SERIALIZATION

  /// Create a GameState from its JSON encoding.
  GameStateView.fromJson(Map<String, dynamic> json)
      : clientPlayer = (json['clientPlayer'] == null)
            ? null
            : Player.fromIndex(json['clientPlayer'] as int),
        activePlayer = Player.fromIndex(json['activePlayer'] as int),
        priorityPlayer = Player.fromIndex(json['priorityPlayer'] as int),
        turnPhase = TurnPhase.fromIndex(json['turnPhase'] as int),
        cards = (json['cards'] as List<dynamic>)
            .map((dynamic data) =>
                CardObjectView.fromJson(data as Map<String, dynamic>))
            .toList(),
        stack = (json['stack'] as List<dynamic>)
            .map((dynamic data) => Event.fromJson(data as Map<String, dynamic>))
            .toList(),
        gameOverState = GameOverState.fromIndex(json['gameOverState'] as int),
        counterAvailable = json['counterAvailable'] as bool;

  /// Encode this GameState as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        if (clientPlayer != null) 'clientPlayer': clientPlayer?.index,
        'activePlayer': activePlayer.index,
        'priorityPlayer': priorityPlayer.index,
        'turnPhase': turnPhase.index,
        'cards': cards,
        'stack': stack,
        'gameOverState': gameOverState.index,
        'counterAvailable': counterAvailable,
      };

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
