import 'package:equatable/equatable.dart';

import '../../game_state/game_state.dart';
import '../../game_state/player.dart';
import '../../objects/game_object.dart';

/// Defines a target to be requested from a player.
abstract class Target extends Equatable {
  /// Which player must answer the request.
  final Player controller;

  /// Whether this can be passed if valid targets exist.
  final bool optional;

  /// Empty target
  const Target({required this.controller, this.optional = false});

  /// Checks if a given target list is valid.
  bool targetValid(List<GameObject> targets);

  /// Checks if any targets are valid for the state.
  bool anyValid(GameState state);

  /// Returns a TargetResult representing the provided targets.
  TargetResult createResult(List<GameObject> targets);

  @override
  List<Object> get props => [controller, optional];

  @override
  bool get stringify => true;
}

/// Result returned from a target request.
abstract class TargetResult extends Equatable {
  /// Empty target result.
  const TargetResult();

  /// GameObjects this result targets.
  List<GameObject> get targets;

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}

/// TargetResult targeting nothing.
class EmptyTargetResult extends TargetResult {
  /// Target result with no targets.
  const EmptyTargetResult();

  @override
  List<GameObject> get targets => const [];

  @override
  List<Object> get props => const [];
}

/// TargetResult before being filled.
class UnfilledTargetRequest extends TargetResult {
  /// TargetResult placeholder.
  const UnfilledTargetRequest();

  @override
  List<GameObject> get targets => throw UnimplementedError();

  @override
  List<Object> get props => const [];
}
