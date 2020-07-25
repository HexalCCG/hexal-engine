class GameStateException implements Exception {
  final String message;

  const GameStateException([this.message]);

  @override
  String toString() => 'GameStateException: $message';
}
