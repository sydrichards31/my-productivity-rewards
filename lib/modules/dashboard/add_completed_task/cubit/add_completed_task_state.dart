part of 'add_completed_task_cubit.dart';

class AddCompletedTaskState {
  final AddCompletedTaskStatus status;
  final DateTime? selectedDate;
  final String? totalPoints;

  const AddCompletedTaskState({
    required this.status,
    required this.selectedDate,
    this.totalPoints,
  });

  AddCompletedTaskState copyWith({
    AddCompletedTaskStatus? status,
    DateTime? selectedDate,
    String? totalPoints,
  }) {
    return AddCompletedTaskState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      totalPoints: totalPoints ?? this.totalPoints,
    );
  }

  List<Object> get props => [
        status,
      ];
}

enum AddCompletedTaskStatus {
  initial,
  dateChanged,
  addingTask,
  success,
  failure,
}
