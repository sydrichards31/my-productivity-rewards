part of 'add_new_task_cubit.dart';

class AddNewTaskState {
  final AddNewTaskStatus status;
  final String description;
  final String points;

  const AddNewTaskState({
    required this.status,
    required this.description,
    required this.points,
  });

  AddNewTaskState copyWith({
    AddNewTaskStatus? status,
    String? description,
    String? points,
  }) {
    return AddNewTaskState(
      status: status ?? this.status,
      description: description ?? this.description,
      points: points ?? this.points,
    );
  }

  bool get addEnabled => description.isNotEmpty && points.isNotEmpty;

  List<Object> get props => [
        status,
        description,
        points,
      ];
}

enum AddNewTaskStatus {
  initial,
  descriptionChanged,
  pointsChanged,
  addingTask,
  success,
  failure,
}
