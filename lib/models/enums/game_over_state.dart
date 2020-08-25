/// Represents whether the game has finished or is continuing.
class GameOverState {
  final int _index;
  const GameOverState._(this._index);

  /// Create a GameState from its JSON encoding.
  GameOverState.fromJson(Map<String, dynamic> json)
      : _index = json['index'] as int;

  /// Encode this GameState as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'index': _index,
      };

  /// Game is still being played.
  static const GameOverState playing = GameOverState._(0);

  /// Game is over and Player 1 has won.
  static const GameOverState player1Win = GameOverState._(1);

  /// Game is over and Player 2 has won.
  static const GameOverState player2Win = GameOverState._(2);

  /// Game is over and neither player has won.
  static const GameOverState draw = GameOverState._(3);
}
