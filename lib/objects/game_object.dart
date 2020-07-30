import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// GameObjects represent anything in the game that can be targeted by effects.
@immutable
abstract class GameObject extends Equatable {
  final int id;

  List<Object> get toStringProps;

  const GameObject({@required this.id});

  @override
  String toString() => _mapPropsToString(runtimeType, toStringProps);

  /// Returns a string for [props].
  String _mapPropsToString(Type runtimeType, List<Object> props) =>
      '$runtimeType${props?.map((prop) => prop?.toString() ?? '') ?? '()'}';

  @override
  List<Object> get props => [id];
}
