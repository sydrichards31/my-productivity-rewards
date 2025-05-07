part of 'add_completed_task_cubit.dart';

class AddCompletedTaskState {
  final AddCompletedTaskStatus status;
  final DateTime? selectedDate;

  const AddCompletedTaskState({
    required this.status,
    required this.selectedDate,
  });

  AddCompletedTaskState copyWith({
    AddCompletedTaskStatus? status,
    DateTime? selectedDate,
  }) {
    return AddCompletedTaskState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
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
