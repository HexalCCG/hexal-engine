import '../mana_amount.dart';

/// Represents an element.
class Element {
  /// Enum index.
  final int index;

  final ManaAmount _mana;

  const Element._(this.index, ManaAmount mana) : _mana = mana;

  /// Create an element from its JSON index.
  factory Element.fromIndex(int _index) => _all[_index];

  /// Encode as json.
  int toJson() => index;

  @override
  String toString() => index.toString();

  static const List<Element> _all = [
    neutral,
    fire,
    earth,
    air,
    water,
    spirit,
    wild
  ];

  /// Gets this element as a manaamount.
  ManaAmount get asMana => _mana;

  /// Neutral element. (0)
  static const Element neutral = Element._(0, ManaAmount(neutral: 1));

  /// Fire. (1)
  static const Element fire = Element._(1, ManaAmount(fire: 1));

  /// Earth. (2)
  static const Element earth = Element._(2, ManaAmount(earth: 1));

  /// Air. (3)
  static const Element air = Element._(3, ManaAmount(air: 1));

  /// Water. (4)
  static const Element water = Element._(4, ManaAmount(water: 1));

  /// Spirit. (5)
  static const Element spirit = Element._(5, ManaAmount(spirit: 1));

  /// Any element. (6)
  static const Element wild = Element._(6, ManaAmount(wild: 1));
}
