import '../../card/creature.dart';
import '../../card/on_enter_field.dart';
import '../../effects/draw_cards_effect.dart';
import '../../effects/effect.dart';
import '../../models/card.dart';
import '../../models/enums/location.dart';
import '../../models/enums/player.dart';

/// 1/2 vanilla creature.
class PeachSapling extends Card with Creature, OnEnterField {
  @override
  int get setId => 1;
  @override
  int get cardId => 7;

  @override
  int get baseAttack => 1;
  @override
  int get baseHealth => 1;

  @override
  List<Effect> get onEnterFieldEffects =>
      [DrawCardsEffect(controller: controller, draws: 1)];

  /// [id] must be unique. [owner] cannot be changed.
  const PeachSapling({
    required int id,
    required Player owner,
    required Player controller,
    required Location location,
    required this.exhausted,
    required this.enteredFieldThisTurn,
    required this.damage,
  }) : super(
          id: id,
          owner: owner,
          controller: controller,
          location: location,
        );

  @override
  final bool exhausted;
  @override
  final bool enteredFieldThisTurn;
  @override
  final int damage;

  @override
  PeachSapling copyWith({
    int? id,
    Player? owner,
    Player? controller,
    Location? location,
  }) =>
      PeachSapling(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        controller: controller ?? this.controller,
        location: location ?? this.location,
        exhausted: exhausted,
        enteredFieldThisTurn: enteredFieldThisTurn,
        damage: damage,
      );

  @override
  PeachSapling copyWithCreature({
    bool? exhausted,
    bool? enteredFieldThisTurn,
    int? damage,
  }) =>
      PeachSapling(
        id: id,
        owner: owner,
        controller: controller,
        location: location,
        exhausted: exhausted ?? this.exhausted,
        enteredFieldThisTurn: enteredFieldThisTurn ?? this.enteredFieldThisTurn,
        damage: damage ?? this.damage,
      );

  /// Create from json.
  static PeachSapling fromJson(List<dynamic> json) => PeachSapling(
        id: json[0] as int,
        owner: Player.fromIndex(json[1] as int),
        controller: Player.fromIndex(json[2] as int),
        location: Location.fromIndex(json[3] as int),
        exhausted: json[4] as bool,
        enteredFieldThisTurn: json[5] as bool,
        damage: json[6] as int,
      );

  @override
  List<Object> get props => [
        id,
        owner,
        controller,
        location,
        exhausted,
        enteredFieldThisTurn,
        damage
      ];
}
