/// Locations in the game that cards can exist in.
class Location {
  /// Enum index.
  final int index;
  const Location._(this.index);

  /// Create a Location from its index.
  factory Location.fromIndex(int _index) => _all[_index];

  /// Encode as json.
  int toJson() => index;

  @override
  String toString() => index.toString();

  static const List<Location> _all = [
    deck,
    hand,
    mana,
    field,
    exile,
    limbo,
  ];

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
