part of 'edit_task_cubit.dart';

class EditTaskState {
  final EditTaskStatus status;
  final String description;
  final String points;

  const EditTaskState({
    required this.status,
    required this.description,
    required this.points,
  });

  EditTaskState copyWith({
    EditTaskStatus? status,
    String? description,
    String? points,
  }) {
    return EditTaskState(
      status: status ?? this.status,
      description: description ?? this.description,
      points: points ?? this.points,
    );
  }

  bool get updateEnabled => description.isNotEmpty && points.isNotEmpty;
  bool get failureStatus =>
      status == EditTaskStatus.deleteTaskFailure ||
      status == EditTaskStatus.updateTaskFailure;

  List<Object> get props => [
        status,
        description,
        points,
      ];
}

enum EditTaskStatus {
  initial,
  descriptionChanged,
  pointsChanged,
  updatingTask,
  updateTaskSuccess,
  updateTaskFailure,
  deletingTask,
  deleteTaskSuccess,
  deleteTaskFailure,
}
