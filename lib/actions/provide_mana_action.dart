import '../exceptions/action_exception.dart';
import '../models/game_state.dart';
import '../state_changes/state_change.dart';
import 'action.dart';

/// Channels a card to provide mana for the top stack event.
class ProvideManaAction extends Action {
  /// Card to channel.
  final int card;

  /// Channels a card to provide mana for the top stack event.
  const ProvideManaAction({required this.card});

  @override
  bool valid(GameState state) {
    return false;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      throw const ActionException(
          'ProvideTargetAction Exception: invalid argument');
    }

    return [];
  }

  @override
  List<Object> get props => [card];

  /// Create from json.
  static ProvideManaAction fromJson(List<dynamic> json) =>
      ProvideManaAction(card: json[0] as int);
}
