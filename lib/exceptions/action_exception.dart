class ActionException implements Exception {
  final String message;

  const ActionException([this.message]);

  @override
  String toString() => 'ActionException: $message';
}
