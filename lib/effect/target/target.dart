import 'package:equatable/equatable.dart';
import 'package:hexal_engine/objects/game_object.dart';

abstract class Target extends Equatable {
  const Target();

  bool targetValid(dynamic target);
  TargetResult createResult(dynamic target);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}

abstract class TargetResult extends Equatable {
  const TargetResult();

  List<GameObject> get targets;

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
