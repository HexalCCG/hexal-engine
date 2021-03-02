import 'hexal_engine_exception.dart';

/// An exception related to an Event.
class JsonFormatException extends HexalEngineException {
  /// [message] is displayed in this exception.
  const JsonFormatException([String? message]) : super(message);

  @override
  String toString() => 'JsonFormatException: $message';
}
