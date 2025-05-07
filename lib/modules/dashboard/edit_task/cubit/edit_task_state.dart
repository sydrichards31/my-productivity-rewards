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
  addingTask,
  taskDeleted,
  success,
  failure,
}
