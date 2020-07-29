extension ListReplace<T> on List<T> {
  List<T> replaceSingle(T toReplace, T replacement) {
    assert(any((element) => element == toReplace));
    return map((e) => e == toReplace ? replacement : e).toList();
  }
}
