import 'package:meta/meta.dart';

import '../game_state/location.dart';
import '../game_state/player.dart';
import 'game_object.dart';

/// CardObjects represent single cards.
@immutable
abstract class CardObject extends GameObject {
  Player get owner;
  Player get controller;
  Location get location;
  bool get enteredFieldThisTurn;

  const CardObject();

  dynamic copyWith(Map<String, dynamic> data);

  @override
  List<Object> get toStringProps =>
      [owner, controller, location, enteredFieldThisTurn];
}
