import 'package:meta/meta.dart';
import 'package:hexal_engine/model/player.dart';

import 'location.dart';

@immutable
class CardObject {
  final int id;
  final Player owner;
  final Player controller;
  final Location location;
  final bool enteredBattlefieldThisTurn;

  const CardObject({
    @required this.id,
    @required this.owner,
    @required this.controller,
    @required this.location,
    @required this.enteredBattlefieldThisTurn,
  });
}
