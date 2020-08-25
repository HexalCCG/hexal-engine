/// Refers to one of the two players.
class Player {
  final int _index;
  const Player._(this._index);

  /// Create a GameState from its JSON encoding.
  Player.fromJson(Map<String, dynamic> json) : _index = json['index'] as int;

  /// Encode this GameState as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'index': _index,
      };

  /// Player one.
  static const Player one = Player._(0);

  /// Player two.
  static const Player two = Player._(1);
}
