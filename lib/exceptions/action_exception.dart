/// An exception related to an Action.
class ActionException implements Exception {
  /// Message to be displayed.
  final String? message;

  /// [message] is displayed in this exception.
  const ActionException([this.message]);

  @override
  String toString() => 'ActionException: $message';
}
