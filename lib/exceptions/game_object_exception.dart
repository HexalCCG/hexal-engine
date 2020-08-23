/// Exception created by a GameObject.
class GameObjectException implements Exception {
  /// Message to be displayed.
  final String? message;

  /// [message] is displayed in this exception.
  const GameObjectException([this.message]);

  @override
  String toString() => 'GameObjectException: $message';
}
