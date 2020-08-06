import '../game_state/location.dart';
import '../game_state/player.dart';
import '../objects/card_object.dart';

/// Card with no stats that provides an effect.
abstract class Spell extends CardObject {
  /// [id] must be unique. [owner] cannot be changed.
  const Spell(
      {required int id,
      required Player owner,
      required Player controller,
      required Location location})
      : super(id: id, owner: owner, controller: controller, location: location);
}
