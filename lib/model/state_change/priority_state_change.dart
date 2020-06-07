import 'package:hexal_engine/model/objects/player_object.dart';
import 'package:meta/meta.dart';
import 'package:hexal_engine/model/state_change/state_change.dart';

class PriorityStateChange extends StateChange {
  final PlayerObject player;
  const PriorityStateChange({@required this.player});

  @override
  List<Object> get props => [player];
}
