part of 'task_log_cubit.dart';

class TaskLogState {
  final TaskLogStatus status;
  final List<CompletedTask> tasks;

  const TaskLogState({
    required this.status,
    required this.tasks,
  });

  TaskLogState copyWith({
    TaskLogStatus? status,
    List<CompletedTask>? tasks,
  }) {
    return TaskLogState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
    );
  }

  List<Object> get props => [
        status,
        tasks,
      ];
}

enum TaskLogStatus {
  loading,
  loaded,
  tasksUpdated,
  failure,
}
