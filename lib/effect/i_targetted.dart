import 'effect.dart';

abstract class ITargetted {
  bool get targetSet;
  bool targetValid(dynamic target);
  Effect copyWithTarget(dynamic target);
}
