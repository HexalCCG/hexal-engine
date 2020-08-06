/// An exception related to an Event.
class EventException implements Exception {
  /// Message to be displayed.
  final String? message;

  /// [message] is displayed in this exception.
  const EventException([this.message]);

  @override
  String toString() => 'EventException: $message';
}
