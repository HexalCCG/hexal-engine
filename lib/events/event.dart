import 'package:meta/meta.dart';

import '../extensions/equatable/equatable.dart';
import '../models/game_state.dart';
import '../state_changes/state_change.dart';
import 'event_index.dart';

/// Events are items placed on the stack to resolve.
@immutable
abstract class Event extends Equatable {
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

  /// Create a Card from its JSON form.
  factory Event.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final data = json['data'] as List<dynamic>;

    final builder = eventBuilders[type];

    if (builder == null) {
      throw ArgumentError('Invalid event type: $type');
    }

    return builder(data);
  }

  /// Properties packaged into json.
  List<Object> get jsonProps => props;

  /// Encode this card as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': runtimeType,
        'data': jsonProps,
      };
}
