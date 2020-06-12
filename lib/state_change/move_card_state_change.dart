import 'package:hexal_engine/exceptions/state_change_exception.dart';
import 'package:meta/meta.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/state_change/state_change.dart';

class MoveCardStateChange extends StateChange {
  final CardObject card;
  final Location location;

  const MoveCardStateChange({@required this.card, @required this.location});

  @override
  GameState apply(GameState state) {
    try {
      state.cards.singleWhere((element) => element == card);
      final newCard = card.copyWith(location: location);
      final newCards = state.cards.toList()
        ..remove(card)
        ..add(newCard);

      return state.copyWith(cards: newCards);
    } catch (e) {
      if (e is StateError) {
        throw StateChangeException(
            'MoveCardStateChange: Provided card not found exactly once in state');
      } else {
        rethrow;
      }
    }
  }

  @override
  List<Object> get props => [card, location];
}