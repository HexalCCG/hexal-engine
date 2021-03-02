import '../models/deck.dart';
import '../models/enums/game_over_state.dart';
import '../models/enums/location.dart';
import '../models/enums/player.dart';
import '../models/enums/turn_phase.dart';
import '../models/game_state.dart';
import '../models/history.dart';

/// Game setup functions.
class GameSetup {
  /// Build a starting game state from deck codes.
  static GameState fromCodes(String playerOneCode, String playerTwoCode) {
    final deck1 = Deck.fromCode(playerOneCode);
    final deck2 = Deck.fromCode(playerTwoCode);

    var cards1 = deck1.toCards(2, Player.one);
    var cards2 = deck2.toCards(cards1.last.id + 1, Player.two);

    cards1.shuffle();
    cards2.shuffle();

    cards1 = [
      ...cards1.take(3).map((card) => card.copyWith(location: Location.hand)),
      ...cards1.skip(3),
    ];
    cards2 = [
      ...cards2.take(4).map((card) => card.copyWith(location: Location.hand)),
      ...cards2.skip(4),
    ];

    return GameState(
      gameOverState: GameOverState.playing,
      cards: [...cards1, ...cards2],
      stack: [],
      history: const History.empty(),
      activePlayer: Player.one,
      priorityPlayer: Player.one,
      turnPhase: TurnPhase.start,
    );
  }
}
