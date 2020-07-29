import 'package:equatable/equatable.dart';

abstract class Target extends Equatable {
  const Target();

  bool targetValid(dynamic target);
  TargetResult createResult(dynamic target);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}

abstract class TargetResult extends Equatable {
  const TargetResult();

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
