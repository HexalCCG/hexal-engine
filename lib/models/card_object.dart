import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'game_object.dart';
import 'location.dart';
import 'player.dart';

/// Allows us to access JSON conversion methods in the generated file.
part 'card_object.g.dart';

/// CardObjects represent single cards.
@immutable
abstract class CardObject extends GameObject {
  /// Player who owns this card.
  final Player owner;

  /// Player who currently controls this.
  final Player controller;

  /// Which zone this is in.
  final Location location;

  /// [id] must be unique and cannot be changed. [owner] cannot be changed.
  @JsonSerializable()
  const CardObject({
    required int id,
    required this.owner,
    required this.controller,
    required this.location,
  }) : super(id: id);

  /// Factory constructor for creating an instance of this from JSON.
  factory CardObject.fromJson(Map<String, dynamic> json) =>
      _$CardObjectFromJson(json);

  /// `toJson` is the convention for a class to declare support for
  /// serialization to JSON. The implementation simply calls the private,
  /// generated helper method `_$GameStateToJson`.
  Map<String, dynamic> toJson() => _$CardObjectToJson(this);

  /// Copy changing base parameters [controller], [location].
  CardObject copyWithBase({Player? controller, Location? location});

  @override
  List<Object> get toStringProps => [owner, controller, location];
}
