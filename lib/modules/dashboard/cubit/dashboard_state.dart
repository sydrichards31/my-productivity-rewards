part of 'dashboard_cubit.dart';

class DashboardState {
  final DashboardStatus status;
  final List<Task> tasks;
  final List<Task> filteredTasks;
  final String points;
  final String goalPoints;

  const DashboardState({
    required this.status,
    required this.tasks,
    required this.filteredTasks,
    required this.points,
    required this.goalPoints,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    List<Task>? tasks,
    List<Task>? filteredTasks,
    String? points,
    String? goalPoints,
  }) {
    return DashboardState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      points: points ?? this.points,
      goalPoints: goalPoints ?? this.goalPoints,
    );
  }

  List<Object> get props => [
        status,
        tasks,
        filteredTasks,
        points,
        goalPoints,
      ];
}

enum DashboardStatus {
  loading,
  loaded,
  tasksUpdated,
  pointsUpdated,
  failure,
  completedTaskAdded,
  searchCleared,
  searched,
}
