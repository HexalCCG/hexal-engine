import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'i_targetable.dart';

class PlayerObject extends Equatable implements ITargetable {
  final String name;

  const PlayerObject({@required this.name});

  @override
  List<Object> get props => [name];
}
