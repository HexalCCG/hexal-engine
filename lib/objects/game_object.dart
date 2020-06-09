import 'package:equatable/equatable.dart';

abstract class GameObject extends Equatable {
  const GameObject();

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
