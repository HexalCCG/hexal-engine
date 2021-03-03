/// Represents whether the game has finished or is continuing.
class GameOverState {
  /// Enum index.
  final int index;
  const GameOverState._(this.index);

  /// Create a GameState from its JSON encoding.
  factory GameOverState.fromIndex(int _index) => _all[_index];

  /// Encode as json.
  int toJson() => index;

  @override
  String toString() => index.toString();

  static const List<GameOverState> _all = [
    playing,
    player1Win,
    player2Win,
    draw
  ];

  /// Game is still being played.
  static const GameOverState playing = GameOverState._(0);

  /// Game is over and Player 1 has won.
  static const GameOverState player1Win = GameOverState._(1);

  /// Game is over and Player 2 has won.
  static const GameOverState player2Win = GameOverState._(2);

  /// Game is over and neither player has won.
  static const GameOverState draw = GameOverState._(3);
}
