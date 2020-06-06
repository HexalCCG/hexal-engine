import 'package:meta/meta.dart';

import '../location.dart';
import 'i_targetable.dart';
import 'player_object.dart';

@immutable
class CardObject implements ITargetable {
  final PlayerObject owner;
  final PlayerObject controller;
  final Location location;
  final bool enteredBattlefieldThisTurn;

  const CardObject({
    @required this.owner,
    @required this.controller,
    @required this.location,
    @required this.enteredBattlefieldThisTurn,
  });
}
