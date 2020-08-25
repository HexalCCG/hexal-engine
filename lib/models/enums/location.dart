/// Locations in the game that cards can exist in.
class Location {
  final int _index;
  const Location._(this._index);

  /// Create a GameState from its JSON encoding.
  Location.fromJson(Map<String, dynamic> json) : _index = json['index'] as int;

  /// Encode this GameState as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'index': _index,
      };

  /// The deck.
  static const deck = Location._(0);

  /// A hand.
  static const hand = Location._(1);

  /// The mana pool.
  static const mana = Location._(2);

  /// The field.
  static const field = Location._(3);

  /// The exile area.
  static const exile = Location._(4);

  /// A temporary space holding cards after they are revealed but before they
  /// enter the field.
  static const limbo = Location._(5);
}
