import 'package:meta/meta.dart';
import 'package:hexal_engine/objects/i_targetable.dart';
import 'action.dart';

class TargetedAbilityAction extends Action {
  final ITargetable object;
  final int ability;
  final ITargetable subject;

  const TargetedAbilityAction({
    @required this.object,
    @required this.ability,
    @required this.subject,
  });

  @override
  List<Object> get props => [object, ability, subject];
}
