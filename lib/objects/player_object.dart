import 'package:meta/meta.dart';

import 'game_object.dart';

class PlayerObject extends GameObject {
  final String name;

  const PlayerObject({@required this.name});

  @override
  List<Object> get props => [name];
}
