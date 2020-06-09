import 'package:meta/meta.dart';

import 'game_object.dart';
import 'i_targetable.dart';

class PlayerObject extends GameObject implements ITargetable {
  final String name;

  const PlayerObject({@required this.name});

  @override
  List<Object> get props => [name];
}
