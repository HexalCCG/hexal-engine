import 'package:hexal_engine/model/actions/action.dart';
import 'package:hexal_engine/model/objects/i_targetable.dart';
import 'package:meta/meta.dart';

class UntargetedAbilityAction extends Action {
  final ITargetable object;
  final int ability;
  final ITargetable subject;

  const UntargetedAbilityAction({
    @required this.object,
    @required this.ability,
    @required this.subject,
  });
}
