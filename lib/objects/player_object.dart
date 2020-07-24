import 'package:meta/meta.dart';

import 'game_object.dart';

/// GameObject representing a player.
@immutable
class PlayerObject extends GameObject {
  @override
  final int id;
  final String name;

  const PlayerObject({@required this.id, @required this.name});

  @override
  List<Object> get toStringProps => [name];

  @override
  List<Object> get props => [id];
}
