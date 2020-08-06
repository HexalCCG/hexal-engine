import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// GameObjects represent anything in the game that can be targeted by effects.
@immutable
abstract class GameObject extends Equatable {
  /// Unique identifying number.
  final int id;

  /// [id] must be unique and cannot be changed.
  const GameObject({required this.id});

  /// Props to be displayed in the object's toString method.
  List<Object> get toStringProps;

  @override
  String toString() => '$runtimeType${props.map((prop) => prop.toString())}';

  @override
  List<Object> get props => [id];
}
