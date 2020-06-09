import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class Action extends Equatable {
  const Action();

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
