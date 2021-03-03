import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../exceptions/action_exception.dart';
import '../exceptions/json_format_exception.dart';
import '../model/game_state.dart';
import '../state_change/state_change.dart';
import 'action_index.dart';

/// Actions represent user inputs.
@immutable
abstract class Action extends Equatable {
  /// Empty action.
  const Action();

  /// Whether this action is valid on the provided state.
  bool valid(GameState state) {
    try {
      validate(state);
    } on ActionException {
      return false;
    }
    return true;
  }

  /// Check validity and throw exceptions on failures.
  void validate(GameState state);

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
    } on FormatException {
      throw const JsonFormatException('Action incorrectly formatted.');
    }
  }

  /// Encode this card as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': runtimeType.toString(),
        'data': props,
      };
}
