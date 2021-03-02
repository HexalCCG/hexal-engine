/// Superclass for exceptions thrown by the Hexal engine.
abstract class HexalEngineException implements Exception {
  /// Message to be displayed.
  final String? message;

  /// Superclass for exceptions thrown by the Hexal engine.
  const HexalEngineException(this.message);

  @override
  String toString();
}
