part of 'daily_checklist_cubit.dart';

class DailyChecklistState {
  final DailyChecklistStatus status;
  final String value;
  final DateTime selectedDate;
  final List<String>? tasks;

  const DailyChecklistState({
    required this.status,
    required this.value,
    required this.selectedDate,
    required this.tasks,
  });

  DailyChecklistState copyWith({
    DailyChecklistStatus? status,
    String? value,
    DateTime? selectedDate,
    List<String>? tasks,
  }) {
    return DailyChecklistState(
      status: status ?? this.status,
      value: value ?? this.value,
      selectedDate: selectedDate ?? this.selectedDate,
      tasks: tasks ?? this.tasks,
    );
  }

  List<Object> get props => [
        status,
        value,
        selectedDate,
      ];
}

enum DailyChecklistStatus {
  initial,
  taskAdded,
  taskRemoved,
  valueChanged,
  dateChanged,
  addingChecklist,
  success,
  failure,
}
