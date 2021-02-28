/// Represents whether an event has succeeded or failed.
class EventState {
  /// Enum index.
  final int index;
  const EventState._(this.index);

  /// Create a GameState from its JSON encoding.
  factory EventState.fromIndex(int _index) => _all[_index];

  /// Encode as json.
  int toJson() => index;

  @override
  String toString() => index.toString();

  static const List<EventState> _all = [
    unresolved,
    succeeded,
    failed,
  ];

  /// Game is still being played.
  static const EventState unresolved = EventState._(0);

  /// Game is over and Player 1 has won.
  static const EventState succeeded = EventState._(1);

  /// Game is over and Player 2 has won.
  static const EventState failed = EventState._(2);
}
