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

  static const List<Element> _all = [fire, earth, air, water, spirit, any];

  /// Fire.
  static const Element fire = Element._(0);

  /// Earth.
  static const Element earth = Element._(1);

  /// Air.
  static const Element air = Element._(2);

  /// Water.
  static const Element water = Element._(3);

  /// Spirit.
  static const Element spirit = Element._(4);

  /// Any element.
  static const Element any = Element._(5);
}
