import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../cards/hidden_card.dart';
import '../card_object.dart';
import '../enums/location.dart';
import '../enums/player.dart';

/// Card represent single cards.
@immutable
class CardObjectView extends Equatable {
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
  const CardObjectView(
      {this.id,
      required this.owner,
      required this.controller,
      required this.location,
      this.setId,
      this.cardId,
      this.data});

  /// Hidden card object view.
  CardObjectView.hidden({
    required this.owner,
    required this.controller,
    required this.location,
  })   : id = null,
        setId = null,
        cardId = null,
        data = null;

  /// View of this card with properties hidden.
  CardObjectView get hiddenView => CardObjectView.hidden(
      owner: owner, controller: controller, location: location);

  /// Create a CardObjectView from a CardObject.
  CardObjectView.fromCardObject(CardObject cardObject)
      : id = cardObject.id,
        owner = cardObject.owner,
        controller = cardObject.controller,
        location = cardObject.location,
        setId = cardObject.setId,
        cardId = cardObject.cardId,
        data = cardObject.jsonProps;

  /// Returns a CardObject representation of this.
  CardObject get asCardObject {
    if (id == null) {
      return HiddenCard(
          owner: owner, controller: controller, location: location);
    } else {
      return CardObject.fromJson(<String, dynamic>{
        'set': setId,
        'number': cardId,
        'data': data,
      });
    }
  }

  /// Create a Card view from its JSON form.
  CardObjectView.fromJson(Map<String, dynamic> json)
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
