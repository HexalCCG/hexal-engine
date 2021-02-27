import 'package:equatable/equatable.dart';

/// Triggered effect history item.
class HistoryTriggeredEffect extends Equatable {
  /// Card the effect is from.
  final int card;

  /// Card's effect index.
  final int triggeredEffectId;

  /// Specific data for effect.
  final List<int> data;

  /// Triggered effect history item.
  const HistoryTriggeredEffect({
    required this.card,
    required this.triggeredEffectId,
    required this.data,
  });

  /// Convert to json.
  List<Object> toJson() => props;

  /// Make this model from json.
  static HistoryTriggeredEffect fromJson(List<dynamic> json) =>
      HistoryTriggeredEffect(
        card: json[0] as int,
        triggeredEffectId: json[1] as int,
        data: (json[2] as List<dynamic>)
            .map<int>((dynamic e) => e as int)
            .toList(),
      );

  @override
  List<Object> get props => [card, triggeredEffectId, data];
}
