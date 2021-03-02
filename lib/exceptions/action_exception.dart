import 'hexal_engine_exception.dart';

/// An exception related to an Action.
class ActionException extends HexalEngineException {
  /// [message] is displayed in this exception.
  const ActionException([String? message]) : super(message);

  @override
  String toString() => 'ActionException: $message';
}
