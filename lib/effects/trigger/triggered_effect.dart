import '../effect.dart';
import 'trigger.dart';

/// Effect activated when trigger occurs.
class TriggeredEffect {
  /// Trigger to activate on.
  final Trigger trigger;

  /// Effect to add.
  final Effect effect;

  /// Whether this effect can be skipped.
  final bool optional;

  /// Effect activated when trigger occurs.
  const TriggeredEffect(
      {required this.trigger, required this.effect, this.optional = true});
}
