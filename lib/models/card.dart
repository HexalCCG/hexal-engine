import 'package:equatable/equatable.dart';

import '../cards/card_index.dart';
import 'card_identity.dart';
import 'enums/element.dart';
import 'enums/location.dart';
import 'enums/player.dart';
import 'mana_amount.dart';

/// Card represent single cards.
abstract class Card extends Equatable {
  /// Unique identifier for this card constant over time.
  final int id;

  /// Player who owns this card.
  final Player owner;

  /// Player who currently controls this.
  final Player controller;

  /// Which zone this is in.
  final Location location;

  /// Whether this card survives on board after the play event resolves.
  bool get permanent;

  /// Element of this card.
  Element get element;

  /// Cost of this card.
  ManaAmount get manaCost => const ManaAmount.zero();

  /// Amount of mana this provides.
  ManaAmount get providesMana => element.asMana;

  /// Identity of this card.
  CardIdentity get identity;

  /// [id] must be unique and cannot be changed. [owner] cannot be changed.
  const Card({
    required this.id,
    required this.owner,
    required this.controller,
    required this.location,
  });

  /// Returns a copy of this object with the changes applied.
  Card copyWith({int id, Player owner, Player controller, Location location});

  /// Create a Card from its JSON form.
  factory Card.fromJson(Map<String, dynamic> json) {
    final identity = CardIdentity.fromJson(json['identity'] as List<dynamic>);

    final builder = cardBuilders[identity];

    if (builder == null) {
      throw ArgumentError('Invalid card identity: $identity');
    }

    return builder(json['data'] as List<dynamic>);
  }

  /// Encode this card as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'identity': identity,
        'data': props,
      };
}
