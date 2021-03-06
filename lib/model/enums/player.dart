/// Refers to one of the two players.
class Player {
  /// Enum index.
  final int index;
  const Player._(this.index);

  /// Create from its index.
  factory Player.fromIndex(int _index) => _all[_index];

  /// Encode as json.
  int toJson() => index;

  @override
  String toString() => index.toString();

  static const List<Player> _all = [
    one,
    two,
  ];

  /// Player one.
  static const Player one = Player._(0);

  /// Player two.
  static const Player two = Player._(1);

  /// Get the other player.
  Player get other => (this == one) ? two : one;
}
