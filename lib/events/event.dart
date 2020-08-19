import 'package:meta/meta.dart';

import '../extensions/equatable/equatable.dart';
import '../models/game_state.dart';
import '../state_changes/state_change.dart';

/// Events are items placed on the stack to resolve.
@immutable
abstract class Event extends Equatable {
  /// Whether this event should be removed.
  final bool resolved;

  /// [Resolved] is whether this event has been applied and needs to be removed.
  const Event({required this.resolved});

  /// Resultant StateChanges of resolving this event.
  List<StateChange> apply(GameState state);

  /// A copy of this event with resolved set to true.
  Event get copyResolved;

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
