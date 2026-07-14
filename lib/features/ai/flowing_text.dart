/// Reveals [text] progressively so the UI can render an AI reply as a
/// flowing/typing effect instead of popping in all at once.
Stream<String> flowText(
  String text, {
  Duration tick = const Duration(milliseconds: 14),
  int step = 3,
}) async* {
  var i = 0;
  while (i < text.length) {
    i = (i + step).clamp(0, text.length);
    yield text.substring(0, i);
    if (i < text.length) {
      await Future.delayed(tick);
    }
  }
}
