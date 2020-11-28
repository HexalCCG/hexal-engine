import 'package:hexal_engine/exceptions/json_format_exception.dart';
import 'package:meta/meta.dart';

import '../extensions/equatable/equatable.dart';
import '../models/game_state.dart';
import '../state_changes/state_change.dart';
import 'action_index.dart';

/// Actions represent user inputs.
@immutable
abstract class Action extends Equatable {
  /// Empty action.
  const Action();

  /// Whether this action is valid on the provided state.
  bool valid(GameState state);

  /// Generate state changes representing this action's effects on the state.
  List<StateChange> apply(GameState state);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;

  /// Create an Event from its JSON form.
  factory Action.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final data = json['data'] as List<dynamic>;

    if (!actionBuilders.keys.any((_type) => _type.toString() == type)) {
      throw ArgumentError('Invalid event type: $type');
    }
    final typeKey =
        actionBuilders.keys.firstWhere((_type) => _type.toString() == type);
    final builder = actionBuilders[typeKey];

    if (builder == null) {
      throw ArgumentError('Invalid event type: $type');
    }

    try {
      return builder(data);
    } catch (e) {
      throw JsonFormatException('Action incorrectly formatted.');
    }
  }

  /// Encode this card as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': runtimeType.toString(),
        'data': props,
      };
}
