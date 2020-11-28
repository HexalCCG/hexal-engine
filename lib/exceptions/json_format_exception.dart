/// An exception related to an Event.
class JsonFormatException implements Exception {
  /// Message to be displayed.
  final String? message;

  /// [message] is displayed in this exception.
  const JsonFormatException([this.message]);

  @override
  String toString() => 'JsonFormatException: $message';
}
