extension ListReplace<T> on List<T> {
  List<T> replaceSingle(T toReplace, T replacement) {
    return map((e) => e == toReplace ? replacement : e).toList();
  }
}
