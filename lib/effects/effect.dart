import '../events/event.dart';
import '../exceptions/json_format_exception.dart';
import 'effect_index.dart';

/// Empty effect.
abstract class Effect extends Event {
  /// Empty effect.
  const Effect({required int id}) : super(id: id);

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
    } on FormatException {
      throw const JsonFormatException('Effect incorrectly formatted.');
    }
  }
}
