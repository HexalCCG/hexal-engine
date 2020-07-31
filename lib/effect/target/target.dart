import 'package:equatable/equatable.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/objects/game_object.dart';
import 'package:meta/meta.dart';

abstract class Target extends Equatable {
  final Player controller;

  const Target({@required this.controller});

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
