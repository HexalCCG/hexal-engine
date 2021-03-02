import 'hexal_engine_exception.dart';

/// An exception related to a StateChange.
class StateChangeException extends HexalEngineException {
  /// [message] is displayed in this exception.
  const StateChangeException([String? message]) : super(message);

  @override
  String toString() => 'StateChangeException: $message';
}
