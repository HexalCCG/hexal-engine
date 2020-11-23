import 'package:meta/meta.dart';

import '../../extensions/equatable/equatable.dart';
import '../card_object.dart';
import '../enums/card_type_view.dart';
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

  /// Whether this card survives on board after the play event resolves.
  final bool? permanent;

  /// ID of this card's set.
  final int? setId;

  /// ID of this card within its set.
  final int? cardId;

  /// View representation of this card's type.
  final CardTypeView? cardType;

  /// [id] uniquely identifies this card.
  const CardObjectView({
    required this.id,
    required this.owner,
    required this.controller,
    required this.location,
    required this.permanent,
    required this.setId,
    required this.cardId,
    required this.cardType,
  });

  /// Hidden card object view.
  CardObjectView.hidden({
    required this.owner,
    required this.controller,
    required this.location,
  })   : id = null,
        permanent = null,
        setId = null,
        cardId = null,
        cardType = null;

  /// View of this card with properties hidden.
  CardObjectView get hiddenView => CardObjectView.hidden(
      owner: owner, controller: controller, location: location);

  /// Create a CardObjectView from a CardObject.
  CardObjectView.fromCardObject(CardObject cardObject)
      : id = cardObject.id,
        owner = cardObject.owner,
        controller = cardObject.controller,
        location = cardObject.location,
        permanent = cardObject.permanent,
        setId = cardObject.setId,
        cardId = cardObject.cardId,
        cardType = CardTypeView.fromCardObject(cardObject);

  /// Create a Card view from its JSON form.
  CardObjectView.fromJson(Map<String, dynamic> json)
      : id = json['set'] as int?,
        owner = Player.fromIndex(json['owner'] as int),
        controller = Player.fromIndex(json['controller'] as int),
        location = Location.fromIndex(json['location'] as int),
        permanent = json['permanent'] as bool?,
        setId = json['setId'] as int?,
        cardId = json['cardId'] as int?,
        cardType = json['cardType'] == null
            ? null
            : CardTypeView.fromIndex(json['cardType'] as int);

  /// Encode this card as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'owner': owner.index,
        'controller': controller.index,
        'location': location.index,
        'permanent': permanent,
        'setId': setId,
        'cardId': cardId,
        'cardType': cardType?.index,
      };

  @override
  List<Object?> get props =>
      [id, owner, controller, location, permanent, setId, cardId, cardType];
}
