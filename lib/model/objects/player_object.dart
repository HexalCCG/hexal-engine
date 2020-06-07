import 'package:equatable/equatable.dart';
import 'package:hexal_engine/model/objects/game_object.dart';
import 'package:meta/meta.dart';
import 'i_targetable.dart';

class PlayerObject extends GameObject implements ITargetable {
  final String name;

  const PlayerObject({@required this.name});

  @override
  List<Object> get props => [name];
}
