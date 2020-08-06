/// An exception related to a GameState.
class GameStateException implements Exception {
  /// Message to be displayed.
  final String? message;

  /// [message] is displayed in this exception.
  const GameStateException([this.message]);

  @override
  String toString() => 'GameStateException: $message';
}
