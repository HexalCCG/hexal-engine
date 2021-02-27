import '../../models/game_state.dart';
import '../../models/history_triggered_effect.dart';
import '../effect.dart';

/// Activator for a triggered effect.
typedef Trigger = bool Function(GameState state);

/// Builder for the triggered effect.
typedef EffectBuilder = Effect Function(GameState state);

/// Builder for effect history.
typedef EffectHistoryBuilder = HistoryTriggeredEffect Function(GameState state);

/// Effect activated when trigger occurs.
class TriggeredEffect {
  /// Trigger to activate on.
  final Trigger trigger;

  /// Effect to add.
  final EffectBuilder effectBuilder;

  /// History to record.
  final EffectHistoryBuilder? historyBuilder;

  /// Whether this effect can be skipped.
  final bool optional;

  /// Effect activated when trigger occurs.
  const TriggeredEffect({
    required this.trigger,
    required this.effectBuilder,
    this.historyBuilder,
    this.optional = true,
  });
}
