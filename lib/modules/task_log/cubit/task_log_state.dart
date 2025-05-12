part of 'task_log_cubit.dart';

class TaskLogState {
  final TaskLogStatus status;
  final List<CompletedTask> tasks;
  final String filterBy;
  final SortDirection sortDirection;

  const TaskLogState({
    required this.status,
    required this.tasks,
    required this.filterBy,
    required this.sortDirection,
  });

  TaskLogState copyWith({
    TaskLogStatus? status,
    List<CompletedTask>? tasks,
    String? filterBy,
    SortDirection? sortDirection,
  }) {
    return TaskLogState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      filterBy: filterBy ?? this.filterBy,
      sortDirection: sortDirection ?? this.sortDirection,
    );
  }

  List<Object> get props => [
        status,
        tasks,
        filterBy,
        sortDirection,
      ];
}

enum TaskLogStatus {
  loading,
  loaded,
  tasksUpdated,
  failure,
  filterByUpdated,
  sortDirectionChanged,
}

enum SortDirection {
  desc,
  asc,
}
