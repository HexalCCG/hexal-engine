import '../../cards/creature.dart';
import '../../cards/spell.dart';
import '../card_object.dart';

/// View of
class CardTypeView {
  /// Enum index.
  final int index;
  const CardTypeView._(this.index);

  /// Create a CardTypeView from its JSON encoding.
  factory CardTypeView.fromIndex(int _index) => _all[_index];

  /// Get a card's type as CardTypeView enum.
  factory CardTypeView.fromCardObject(CardObject cardObject) {
    if (cardObject is Creature) {
      return CardTypeView.creature;
    } else if (cardObject is Spell) {
      return CardTypeView.spell;
    } else {
      return CardTypeView.other;
    }
  }

  /// Encode as json.
  int toJson() => index;

  @override
  String toString() => index.toString();

  static const List<CardTypeView> _all = [
    spell,
    item,
    creature,
    other,
  ];

  /// Does not block attacks.
  static const CardTypeView spell = CardTypeView._(0);

  /// Does not block attacks.
  static const CardTypeView item = CardTypeView._(1);

  /// Can block attacks.
  static const CardTypeView creature = CardTypeView._(2);

  /// Not a spell, item, or creature.
  static const CardTypeView other = CardTypeView._(3);
}
