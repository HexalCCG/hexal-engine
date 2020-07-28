abstract class IInputRequired {
  bool get needsInput;
  bool targetValid(dynamic target);
  dynamic copyWithTarget(dynamic target);
}
