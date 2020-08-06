/// Provides a method on List to replace a single element in place.
extension ListReplace<T> on List<T> {
  /// Replaces [toReplace] in the List in place with [replacement] and returns
  /// a resulting List.
  List<T> replaceSingle(T toReplace, T replacement) {
    assert(any((element) => element == toReplace));
    return map((e) => e == toReplace ? replacement : e).toList();
  }
}
