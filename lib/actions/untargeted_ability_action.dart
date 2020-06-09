import 'package:meta/meta.dart';

import '../objects/i_targetable.dart';
import 'action.dart';

class UntargetedAbilityAction extends Action {
  final ITargetable object;
  final int ability;
  final ITargetable subject;

  const UntargetedAbilityAction({
    @required this.object,
    @required this.ability,
    @required this.subject,
  });

  @override
  List<Object> get props => [object, ability, subject];
}
