import 'hexal_engine_exception.dart';

/// An exception related to a GameState.
class GameStateException extends HexalEngineException {
  /// [message] is displayed in this exception.
  const GameStateException([String? message]) : super(message);

  @override
  String toString() => 'GameStateException: $message';
}
