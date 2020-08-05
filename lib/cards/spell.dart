import 'package:meta/meta.dart';

import '../game_state/location.dart';
import '../game_state/player.dart';
import '../objects/card_object.dart';

abstract class Spell extends CardObject {
  const Spell(
      {@required int id,
      @required Player owner,
      @required Player controller,
      @required Location location})
      : super(id: id, owner: owner, controller: controller, location: location);
}
