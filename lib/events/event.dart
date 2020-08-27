import 'package:meta/meta.dart';

import '../extensions/equatable/equatable.dart';
import '../models/game_state.dart';
import '../state_changes/state_change.dart';
import 'event_index.dart';

/// Events are items placed on the stack to resolve.
@immutable
abstract class Event extends Equatable {
  /// Events are items placed on the stack to resolve.
  const Event();

  /// Whether this event should be removed.
  bool get resolved;

  /// Whether this event is valid on the provided state.
  bool valid(GameState state);

  /// Resultant StateChanges of resolving this event.
  List<StateChange> apply(GameState state);

  /// A copy of this event with resolved set to true.
  Event get copyResolved;

  @override
  List<Object> get props;

  /// Create an Event from its JSON form.
  factory Event.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final data = json['data'] as List<dynamic>;

    if (!eventBuilders.keys.any((_type) => _type.toString() == type)) {
      throw ArgumentError('Invalid event type: $type');
    }
    final typeKey =
        eventBuilders.keys.firstWhere((_type) => _type.toString() == type);
    final builder = eventBuilders[typeKey];

    if (builder == null) {
      throw ArgumentError('Invalid event type: $type');
    }

    return builder(data);
  }

  /// Encode this card as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': runtimeType.toString(),
        'data': props,
      };
}
