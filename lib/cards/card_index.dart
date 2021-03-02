import '../cards/00_token/set_00.dart';
import '../cards/01_basic/set_01.dart';
import '../card/card.dart';
import '../models/card_identity.dart';

/// Container for functions creating cards from json.
final Map<CardIdentity, Card> cardBuilders = {
  ...set_00,
  ...set_01,
};
