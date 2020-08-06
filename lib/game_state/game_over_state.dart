/// Represents whether the game has finished or is continuing.
enum GameOverState {
  /// Game is still being played.
  playing,

  /// Game is over and Player 1 has won.
  player1Win,

  /// Game is over and Player 2 has won.
  player2Win,

  /// Game is over and neither player has won.
  draw,
}
