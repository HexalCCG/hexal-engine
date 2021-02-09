import 'package:meta/meta.dart';

import '../cards/card_index.dart';
import 'enums/location.dart';
import 'enums/player.dart';
import 'game_object.dart';

/// Card represent single cards.
@immutable
abstract class Card extends GameObject {
  /// Player who owns this card.
  final Player owner;

  /// Player who currently controls this.
  final Player controller;

  /// Which zone this is in.
  final Location location;

  /// Whether this card survives on board after the play event resolves.
  bool get permanent;

  /// ID of this card's set.
  int get setId;

  /// ID of this card within its set.
  int get cardId;

  /// [id] must be unique and cannot be changed. [owner] cannot be changed.
  const Card({
    required int id,
    required this.owner,
    required this.controller,
    required this.location,
  }) : super(id: id);

  @override
  Card copyWith({int id, Player owner, Player controller, Location location});

  /// Create a Card from its JSON form.
  factory Card.fromJson(Map<String, dynamic> json) {
    final cardSet = json['set'] as int;
    final cardId = json['number'] as int;
    final data = json['data'] as List<dynamic>;

    final builder = setBuilders[cardSet]?[cardId];

    if (builder == null) {
      throw ArgumentError('Invalid card ID: $cardSet:$cardId');
    }

    return builder(data);
  }

  /// Properties packaged into json.
  List<Object> get jsonProps => props;

  /// Encode this card as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'set': setId,
        'number': cardId,
        'data': jsonProps,
      };
}
