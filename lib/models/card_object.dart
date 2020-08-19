import 'package:meta/meta.dart';

import 'game_object.dart';
import 'location.dart';
import 'player.dart';

/// CardObjects represent single cards.
@immutable
abstract class CardObject extends GameObject {
  /// Player who owns this card.
  final Player owner;

  /// Player who currently controls this.
  final Player controller;

  /// Which zone this is in.
  final Location location;

  /// [id] must be unique and cannot be changed. [owner] cannot be changed.
  const CardObject({
    required int id,
    required this.owner,
    required this.controller,
    required this.location,
  }) : super(id: id);

  /// Copy changing base parameters [controller], [location].
  CardObject copyWithBase({Player? controller, Location? location});

  @override
  List<Object> get toStringProps => [owner, controller, location];
}
