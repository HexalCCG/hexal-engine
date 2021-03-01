import 'package:equatable/equatable.dart';

import '../card/creature.dart';
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
  Card copyWith(
      {int? id, Player? owner, Player? controller, Location? location});

  /// Create a Card from its JSON form.
  factory Card.fromJson(Map<String, dynamic> json) {
    final identity = CardIdentity.fromJson(json['identity'] as List<dynamic>);

    var card = cardBuilders[identity];

    if (card == null) {
      throw ArgumentError('Invalid card identity: $identity');
    }

    card = card.copyWith(
      id: json['data']['id'] as int,
      owner: Player.fromIndex(json['data']['owner'] as int),
      controller: Player.fromIndex(json['data']['controller'] as int),
      location: Location.fromIndex(json['data']['location'] as int),
    );

    if (card is Creature) {
      card = card.copyWithCreature(
        damage: json['data']['damage'] as int,
      );
    }

    return card;
  }

  /// Create a card from its identity.
  factory Card.fromIdentity(CardIdentity identity, int id) {
    var card = cardBuilders[identity];

    if (card == null) {
      throw ArgumentError('Invalid card identity: $identity');
    }

    return card.copyWith(id: id);
  }

  /// Encode this card as JSON.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'owner': owner,
      'controller': controller,
      'location': location,
    };

    if (this is Creature) {
      data.addAll(
        <String, dynamic>{
          'damage': (this as Creature).damage,
        },
      );
    }

    return <String, dynamic>{
      'identity': identity,
      'data': data,
    };
  }

  @override
  List<Object?> get props {
    final data = [id, owner, controller, location];
    if (this is Creature) {
      data.add((this as Creature).damage);
    }
    return data;
  }
}
