import '../models/game_state.dart';
import '../models/history.dart';
import 'state_change.dart';

/// Clears turn history.
class ClearHistory extends StateChange {
  /// Clears turn history.
  const ClearHistory();

  @override
  GameState apply(GameState state) {
    return state.copyWith(history: const History.empty());
  }

  @override
  List<Object> get props => [];
}
