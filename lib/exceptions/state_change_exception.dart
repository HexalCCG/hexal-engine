/// An exception related to a StateChange.
class StateChangeException implements Exception {
  /// Message to be displayed.
  final String? message;

  /// [message] is displayed in this exception.
  const StateChangeException([this.message]);

  @override
  String toString() => 'StateChangeException: $message';
}
