class StateChangeException implements Exception {
  final String message;

  const StateChangeException([this.message]);

  @override
  String toString() => 'CardNotFoundException: $message';
}
