import 'package:meta/meta.dart';
import 'i_targetable.dart';

class PlayerObject implements ITargetable {
  final String name;
  const PlayerObject({@required this.name});
}
