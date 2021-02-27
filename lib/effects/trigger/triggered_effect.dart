import '../../models/game_state.dart';
import '../effect.dart';

/// Activator for a triggered effect.
typedef Trigger = bool Function(GameState state);

/// Builder for the triggered effect.
typedef EffectBuilder = Effect Function(GameState state);

/// Effect activated when trigger occurs.
class TriggeredEffect {
  /// Trigger to activate on.
  final Trigger trigger;

  /// Effect to add.
  final EffectBuilder effectBuilder;

  /// Whether this effect can be skipped.
  final bool optional;

  /// Effect activated when trigger occurs.
  const TriggeredEffect({
    required this.trigger,
    required this.effectBuilder,
    this.optional = true,
  });
}
