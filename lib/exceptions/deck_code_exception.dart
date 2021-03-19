import 'hexal_engine_exception.dart';

/// Exceptions thrown when handling deck codes.
class DeckCodeException extends HexalEngineException {
  /// [message] is displayed in this exception.
  const DeckCodeException([String? message]) : super(message);

  @override
  String toString() => 'ActionException: $message';
}
