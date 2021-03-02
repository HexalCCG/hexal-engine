import 'hexal_engine_exception.dart';

/// An exception related to an Event.
class EventException extends HexalEngineException {
  /// [message] is displayed in this exception.
  const EventException([String? message]) : super(message);

  @override
  String toString() => 'EventException: $message';
}
