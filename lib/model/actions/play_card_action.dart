import 'package:meta/meta.dart';
import 'package:hexal_engine/model/actions/action.dart';
import 'package:hexal_engine/model/objects/i_targetable.dart';

class PlayCardAction extends Action {
  final ITargetable object;

  const PlayCardAction({@required this.object});
}
