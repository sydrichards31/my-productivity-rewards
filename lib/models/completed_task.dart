class CompletedTask {
  final int? taskId;
  final String description;
  final int points;
  final String date;

  const CompletedTask({
    this.taskId,
    required this.description,
    required this.points,
    required this.date,
  });
}
