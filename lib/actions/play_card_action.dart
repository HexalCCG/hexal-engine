import 'package:meta/meta.dart';

import '../objects/i_targetable.dart';
import 'action.dart';

class PlayCardAction extends Action {
  final ITargetable object;

  const PlayCardAction({@required this.object});

  @override
  List<Object> get props => [object];
}
