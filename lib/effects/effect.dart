import 'package:hexal_engine/exceptions/json_format_exception.dart';

import '../events/event.dart';
import '../models/enums/player.dart';
import 'effect_index.dart';

/// Empty effect.
abstract class Effect extends Event {
  /// Empty effect.
  const Effect();

  /// Player that controls this effect and will provide targets.
  Player get controller;

  /// Create an Event from its JSON form.
  factory Effect.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final data = json['data'] as List<dynamic>;

    if (!effectBuilders.keys.any((_type) => _type.toString() == type)) {
      throw ArgumentError('Invalid event type: $type');
    }
    final typeKey =
        effectBuilders.keys.firstWhere((_type) => _type.toString() == type);
    final builder = effectBuilders[typeKey];

    if (builder == null) {
      throw ArgumentError('Builder missing from index: $type');
    }

    try {
      return builder(data);
    } catch (e) {
      throw JsonFormatException('Effect incorrectly formatted.');
    }
  }
}
