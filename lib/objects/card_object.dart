import 'package:meta/meta.dart';

import '../game_state/location.dart';
import '../game_state/player.dart';
import 'game_object.dart';

/// CardObjects represent single cards.
@immutable
abstract class CardObject extends GameObject {
  final Player owner;
  final Player controller;
  final Location location;

  const CardObject({
    @required int id,
    @required this.owner,
    @required this.controller,
    @required this.location,
  }) : super(id: id);

  dynamic copyWith(Map<String, dynamic> data);

  @override
  List<Object> get toStringProps => [owner, controller, location];
}
