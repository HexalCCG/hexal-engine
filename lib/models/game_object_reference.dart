import 'game_object.dart';

/// Reference to a card by id only.
class GameObjectReference extends GameObject {
  /// Reference to a card by id only.
  const GameObjectReference({required int id}) : super(id: id);

  @override
  GameObject copyWith({int? id}) => GameObjectReference(id: id ?? this.id);

  @override
  List<Object> get props => [id];

  /// Create a game object reference from json.
  GameObjectReference.fromJson(int json) : super(id: json);

  /// Encode this as json.
  int toJson() => id;
}
