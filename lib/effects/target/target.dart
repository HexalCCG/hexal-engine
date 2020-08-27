import '../../extensions/equatable/equatable.dart';
import '../../models/enums/player.dart';
import '../../models/game_object_reference.dart';
import '../../models/game_state.dart';
import 'target_index.dart';

/// Defines a target to be requested from a player.
abstract class Target extends Equatable {
  /// Which player must answer the request.
  Player get controller;

  /// Whether this can be passed if valid targets exist.
  bool get optional;

  /// Defines a target to be requested from a player.
  const Target();

  /// Checks if a given target list is valid.
  bool targetValid(GameState state, List<GameObjectReference> targets);

  /// Checks if any targets are valid for the state.
  bool anyValid(GameState state);

  /// Create a target from its JSON form.
  factory Target.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final data = json['data'] as List<dynamic>;

    if (!targetBuilders.keys.any((_type) => _type.toString() == type)) {
      throw ArgumentError('Invalid event type: $type');
    }
    final typeKey =
        targetBuilders.keys.firstWhere((_type) => _type.toString() == type);
    final builder = targetBuilders[typeKey];

    if (builder == null) {
      throw ArgumentError('Builder missing from index: $type');
    }

    return builder(data);
  }

  /// Encode this target as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': runtimeType.toString(),
        'data': props,
      };
}
