import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../extensions/equatable/equatable.dart';

/// Allows us to access JSON conversion methods in the generated file.
part 'game_object.g.dart';

/// GameObjects represent anything in the game that can be targeted by effects.
@immutable
@JsonSerializable()
abstract class GameObject extends Equatable {
  /// Unique identifying number.
  final int id;

  /// [id] must be unique and cannot be changed.
  const GameObject({required this.id});

  /// Factory constructor for creating an instance of this from JSON.
  factory GameObject.fromJson(Map<String, dynamic> json) =>
      _$GameObjectFromJson(json);

  /// `toJson` is the convention for a class to declare support for
  /// serialization to JSON. The implementation simply calls the private,
  /// generated helper method `_$GameStateToJson`.
  Map<String, dynamic> toJson() => _$GameObjectFromJson(this);

  /// Props to be displayed in the object's toString method.
  List<Object> get toStringProps;

  @override
  String toString() => '$runtimeType${props.map((prop) => prop.toString())}';

  @override
  List<Object> get props => [id];
}
