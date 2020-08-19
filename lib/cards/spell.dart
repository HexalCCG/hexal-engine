import '../models/card_object.dart';
import '../models/location.dart';
import '../models/player.dart';

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
