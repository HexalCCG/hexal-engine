class EventException implements Exception {
  final String message;

  const EventException([this.message]);

  @override
  String toString() => 'EventException: $message';
}
