String formattedRuntime(int? runtime) {
  final int hours = runtime! ~/ 60;
  final int minutes = runtime % 60;
  return '${hours}h $minutes min';
}
