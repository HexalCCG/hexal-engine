import '../cards/card_index.dart';
import 'card_identity.dart';
import 'enums/location.dart';
import 'enums/player.dart';
import 'game_object.dart';

/// Card represent single cards.
abstract class Card extends GameObject {
  /// Player who owns this card.
  final Player owner;

  /// Player who currently controls this.
  final Player controller;

  /// Which zone this is in.
  final Location location;

  /// Whether this card survives on board after the play event resolves.
  bool get permanent;

  /// Identity of this card.
  CardIdentity get identity;

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
    final identity = CardIdentity.fromJson(json['identity'] as List<int>);
    final data = json['data'] as List<dynamic>;

    final builder = setBuilders[identity.setId]?[identity.cardId];

    if (builder == null) {
      throw ArgumentError('Invalid card ID: $identity');
    }

    return builder(data);
  }

  /// Properties packaged into json.
  List<Object?> get jsonProps => props;

  /// Encode this card as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'identity': identity,
        'data': jsonProps,
      };
}
