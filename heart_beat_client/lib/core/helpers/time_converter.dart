class TimeConverter {
  static String convertTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    final paddedSeconds = remainingSeconds.toString().padLeft(2, '0');
    return '$minutes:$paddedSeconds';
  }
}
