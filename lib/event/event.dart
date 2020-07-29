import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../state_change/state_change.dart';

/// Events are items placed on the stack to resolve.
@immutable
abstract class Event extends Equatable {
  final bool resolved;

  const Event({@required this.resolved});

  List<StateChange> apply(GameState state);

  Event get copyResolved;

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
