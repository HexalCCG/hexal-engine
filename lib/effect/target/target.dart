import 'package:equatable/equatable.dart';

abstract class Target extends Equatable {
  const Target();

  bool targetValid(dynamic target);
  bool get targetSet;
  Target setTarget(dynamic target);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
