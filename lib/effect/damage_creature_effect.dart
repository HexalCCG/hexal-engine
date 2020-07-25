import 'package:meta/meta.dart';

import '../cards/mi_creature.dart';
import '../event/event.dart';
import '../game_state/game_state.dart';
import 'effect.dart';

class DamageCreatureEffect extends Effect {
  final ICreature creature;
  final int damage;

  const DamageCreatureEffect({@required this.creature, @required this.damage});

  @override
  List<Event> apply(GameState state) {
    return [];
  }

  @override
  List<Object> get props => throw UnimplementedError();
}
