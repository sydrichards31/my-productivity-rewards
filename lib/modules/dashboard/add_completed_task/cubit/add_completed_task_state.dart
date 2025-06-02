part of 'add_completed_task_cubit.dart';

class AddCompletedTaskState {
  final AddCompletedTaskStatus status;
  final DateTime? selectedDate;
  final String? totalPoints;
  final String description;
  final String points;

  const AddCompletedTaskState({
    required this.status,
    required this.selectedDate,
    required this.description,
    required this.points,
    this.totalPoints,
  });

  AddCompletedTaskState copyWith({
    AddCompletedTaskStatus? status,
    DateTime? selectedDate,
    String? totalPoints,
    String? description,
    String? points,
  }) {
    return AddCompletedTaskState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      totalPoints: totalPoints ?? this.totalPoints,
      description: description ?? this.description,
      points: points ?? this.points,
    );
  }

  List<Object> get props => [
        status,
        description,
        points,
      ];
}

enum AddCompletedTaskStatus {
  initial,
  dateChanged,
  descriptionChanged,
  pointsChanged,
  addingTask,
  success,
  failure,
}
