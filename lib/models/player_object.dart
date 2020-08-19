import 'package:json_annotation/json_annotation.dart';

import '../models/player.dart';
import 'game_object.dart';

/// Allows us to access JSON conversion methods in the generated file.
part 'player_object.g.dart';

/// GameObject to represent a player for targeting.
@JsonSerializable()
class PlayerObject extends GameObject {
  /// Which player this object represents.
  final Player player;

  /// Represents one of the players.
  /// [id] should be 0 for Player One, and 1 for Player Two.
  const PlayerObject({required int id, required this.player}) : super(id: id);

  /// Factory constructor for creating an instance of this from JSON.
  factory PlayerObject.fromJson(Map<String, dynamic> json) =>
      _$PlayerObjectFromJson(json);

  /// `toJson` is the convention for a class to declare support for
  /// serialization to JSON. The implementation simply calls the private,
  /// generated helper method `_$GameStateToJson`.
  Map<String, dynamic> toJson() => _$PlayerObjectFromJson(this);

  @override
  List<Object> get toStringProps => [id, player];
}
