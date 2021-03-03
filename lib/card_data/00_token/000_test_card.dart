import '../../card/spell.dart';
import '../../card/card.dart';
import '../../model/card_identity.dart';
import '../../model/enums/element.dart';
import '../../model/enums/location.dart';
import '../../model/enums/player.dart';

/// Test spell with no effects or cost.
class TestCard extends Card with Spell {
  @override
  CardIdentity get identity => const CardIdentity(0, 0);

  @override
  Element get element => Element.neutral;

  /// [id] must be unique. [owner] cannot be changed.
  const TestCard({
    int id = 0,
    Player owner = Player.one,
    Player controller = Player.one,
    Location location = Location.deck,
  }) : super(id: id, owner: owner, controller: controller, location: location);

  @override
  TestCard copyWith(
          {int? id, Player? owner, Player? controller, Location? location}) =>
      TestCard(
          id: id ?? this.id,
          owner: owner ?? this.owner,
          controller: controller ?? this.controller,
          location: location ?? this.location);
}
