import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../cards/hidden_card.dart';
import '../card.dart';
import '../enums/location.dart';
import '../enums/player.dart';

/// Card represent single cards.
@immutable
class CardView extends Equatable {
  /// Unique identifier for this card.
  final int? id;

  /// Player who owns this card.
  final Player owner;

  /// Player who currently controls this.
  final Player controller;

  /// Which zone this is in.
  final Location location;

  /// ID of this card's set.
  final int? setId;

  /// ID of this card within its set.
  final int? cardId;

  /// Optional list of json data for this card.
  final List<Object>? data;

  /// [id] uniquely identifies this card.
  const CardView(
      {this.id,
      required this.owner,
      required this.controller,
      required this.location,
      this.setId,
      this.cardId,
      this.data});

  /// Hidden card object view.
  CardView.hidden({
    required this.owner,
    required this.controller,
    required this.location,
  })   : id = null,
        setId = null,
        cardId = null,
        data = null;

  /// View of this card with properties hidden.
  CardView get hiddenView =>
      CardView.hidden(owner: owner, controller: controller, location: location);

  /// Create a CardView from a Card.
  CardView.fromCard(Card card)
      : id = card.id,
        owner = card.owner,
        controller = card.controller,
        location = card.location,
        setId = card.setId,
        cardId = card.cardId,
        data = card.jsonProps;

  /// Returns a Card representation of this.
  Card get asCard {
    if (id == null) {
      return HiddenCard(
          owner: owner, controller: controller, location: location);
    } else {
      return Card.fromJson(<String, dynamic>{
        'set': setId,
        'number': cardId,
        'data': data,
      });
    }
  }

  /// Create a Card view from its JSON form.
  CardView.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        owner = Player.fromIndex(json['owner'] as int),
        controller = Player.fromIndex(json['controller'] as int),
        location = Location.fromIndex(json['location'] as int),
        setId = json['setId'] as int?,
        cardId = json['cardId'] as int?,
        data = json['data'] as List<Object>?;

  /// Encode this card as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'owner': owner.index,
        'controller': controller.index,
        'location': location.index,
        'setId': setId,
        'cardId': cardId,
      };

  @override
  List<Object?> get props => [id, owner, controller, location, setId, cardId];
}
