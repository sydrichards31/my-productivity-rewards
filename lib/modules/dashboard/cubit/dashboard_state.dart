part of 'dashboard_cubit.dart';

class DashboardState {
  final DashboardStatus status;
  final List<Task> tasks;
  final String points;
  final String goalPoints;

  const DashboardState({
    required this.status,
    required this.tasks,
    required this.points,
    required this.goalPoints,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    List<Task>? tasks,
    String? points,
    String? goalPoints,
  }) {
    return DashboardState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      points: points ?? this.points,
      goalPoints: goalPoints ?? this.goalPoints,
    );
  }

  List<Object> get props => [
        status,
        tasks,
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
}
