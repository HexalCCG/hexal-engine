import '../model/game_state.dart';
import '../model/history_triggered_effect.dart';
import 'state_change.dart';

/// Add history triggered effect.
class HistoryTriggeredEffectStateChange extends StateChange {
  /// History triggered effect to add.
  final HistoryTriggeredEffect historyTriggeredEffect;

  /// Add history triggered effect.
  const HistoryTriggeredEffectStateChange({
    required this.historyTriggeredEffect,
  });

  @override
  GameState apply(GameState state) {
    return state.copyWith(
      history: state.history.addTriggeredEffect(historyTriggeredEffect),
    );
  }

  @override
  List<Object> get props => [historyTriggeredEffect];
}
