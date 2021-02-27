import '../../card/on_trigger.dart';
import '../../effects/draw_cards_effect.dart';
import '../../effects/trigger/triggered_effect.dart';
import '../../models/card.dart';
import '../../models/card_identity.dart';
import '../../models/enums/element.dart';
import '../../models/enums/location.dart';
import '../../models/enums/player.dart';
import '../../models/mana_amount.dart';

/// Earth Hero. "When you summon an [Earth] creature, draw a card".
class HivequeenNgaat extends Card with OnTrigger {
  @override
  CardIdentity get identity => const CardIdentity(1, 0);

  @override
  bool get permanent => true;

  @override
  Element get element => Element.earth;

  @override
  ManaAmount get manaCost => const ManaAmount(earth: 4);

  @override
  List<TriggeredEffect> get onTriggerEffects => [
        TriggeredEffect(
          trigger: (state) => false,
          effectBuilder: (state) =>
              DrawCardsEffect(draws: 2, player: controller),
        )
      ];

  /// Earth Hero. "When you summon an [Earth] creature, draw a card".
  const HivequeenNgaat({
    required int id,
    required Player owner,
    required Player controller,
    required Location location,
  }) : super(
          id: id,
          owner: owner,
          controller: controller,
          location: location,
        );

  @override
  HivequeenNgaat copyWith({
    int? id,
    Player? owner,
    Player? controller,
    Location? location,
  }) =>
      HivequeenNgaat(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        controller: controller ?? this.controller,
        location: location ?? this.location,
      );

  /// Create from json.
  static HivequeenNgaat fromJson(List<dynamic> json) => HivequeenNgaat(
        id: json[0] as int,
        owner: Player.fromIndex(json[1] as int),
        controller: Player.fromIndex(json[2] as int),
        location: Location.fromIndex(json[3] as int),
      );

  @override
  List<Object> get props => [id, owner, controller, location];
}
