import 'package:meta/meta.dart';

import '../extensions/equatable/equatable.dart';

/// GameObjects represent anything in the game that can be targeted by effects.
@immutable
abstract class GameObject extends Equatable {
  /// Unique identifying number.
  final int id;

  /// [id] must be unique and cannot be changed.
  const GameObject({required this.id});

  @override
  String toString() => '$runtimeType${props.map((prop) => prop.toString())}';

  @override
  List<Object> get props;

  /// Returns a copy of this object with the changes applied.
  GameObject copyWith(Map<String, dynamic> changes);
}
