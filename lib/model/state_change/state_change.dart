import 'package:equatable/equatable.dart';

abstract class StateChange extends Equatable {
  const StateChange();

  @override
  List<Object> get props;
}
