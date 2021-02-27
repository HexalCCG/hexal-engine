import '../events/channel_card_event.dart';
import '../events/require_mana_event.dart';
import '../exceptions/action_exception.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/priority_state_change.dart';
import '../state_changes/state_change.dart';
import 'action.dart';

/// Channels a card to provide mana for the top stack event.
class ProvideManaAction extends Action {
  /// Card to channel.
  final int card;

  /// Channels a card to provide mana for the top stack event.
  const ProvideManaAction({required this.card});

  @override
  void validate(GameState state) {
    if (state.stack.isEmpty) {
      throw const ActionException('ProvideManaAction: Stack is empty.');
    }

    final event = state.stack.last;

    // Top stack event must be a require mana event.
    if (event is! RequireManaEvent) {
      throw const ActionException(
          'ProvideManaAction: Top event in stack is not a RequireManaEvent.');
    }

    // Make sure the mana require event is still going.
    if (!event.valid(state)) {
      throw const ActionException(
          'ProvideManaAction: RequireManaEvent is not valid.');
    }
  }

  @override
  List<StateChange> apply(GameState state) {
    validate(state);

    return [
      AddEventStateChange(
        event: ChannelCardEvent(
          card: card,
          controller: state.priorityPlayer,
          targetCard: (state.stack.last as RequireManaEvent).card,
        ),
      ),
      PriorityStateChange(player: state.activePlayer),
    ];
  }

  @override
  List<Object> get props => [card];

  /// Create from json.
  static ProvideManaAction fromJson(List<dynamic> json) =>
      ProvideManaAction(card: json[0] as int);
}
