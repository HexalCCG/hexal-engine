import 'package:meta/meta.dart';

import 'enums/location.dart';
import 'enums/player.dart';
import 'game_object.dart';

/// CardObjects represent single cards.
@immutable
abstract class CardObject extends GameObject {
  /// Player who owns this card.
  final Player owner;

  /// Player who currently controls this.
  final Player controller;

  /// Which zone this is in.
  final Location location;

  /// Whether this card survives on board after the play event resolves.
  bool get permanent;

  /// [id] must be unique and cannot be changed. [owner] cannot be changed.
  const CardObject({
    required int id,
    required this.owner,
    required this.controller,
    required this.location,
  }) : super(id: id);

  @override
  CardObject copyWith(
      {int id, Player owner, Player controller, Location location});
}