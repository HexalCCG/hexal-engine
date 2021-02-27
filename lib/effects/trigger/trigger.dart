import '../../models/card.dart';
import '../../models/game_state.dart';

/// Activator for a triggered effect.
typedef Trigger = bool Function(GameState state, Card card);
