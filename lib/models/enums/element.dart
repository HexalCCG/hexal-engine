/// Represents an element.
class Element {
  /// Enum index.
  final int index;
  const Element._(this.index);

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
    any
  ];

  /// Neutral element. (0)
  static const Element neutral = Element._(0);

  /// Fire. (1)
  static const Element fire = Element._(1);

  /// Earth. (2)
  static const Element earth = Element._(2);

  /// Air. (3)
  static const Element air = Element._(3);

  /// Water. (4)
  static const Element water = Element._(4);

  /// Spirit. (5)
  static const Element spirit = Element._(5);

  /// Any element. (6)
  static const Element any = Element._(6);
}
