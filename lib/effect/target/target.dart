import 'package:equatable/equatable.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/objects/game_object.dart';
import 'package:meta/meta.dart';

abstract class Target extends Equatable {
  final Player controller;
  final bool optional;

  const Target({@required this.controller, this.optional = false});

  bool targetValid(dynamic target);
  bool anyValid(GameState state);
  TargetResult createResult(dynamic target);

  @override
  List<Object> get props => [controller, optional];

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

class EmptyTargetResult extends TargetResult {
  const EmptyTargetResult();

  @override
  List<GameObject> get targets => const [];

  @override
  List<Object> get props => const [];
}
