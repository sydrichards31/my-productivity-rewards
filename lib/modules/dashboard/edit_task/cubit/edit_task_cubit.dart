// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/models/models.dart';
import 'package:my_productive_rewards/services/database_service.dart';

part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final descriptionTextController = TextEditingController();
  final pointsTextController = TextEditingController();
  EditTaskCubit({required Task task})
      : super(
          EditTaskState(
            status: EditTaskStatus.initial,
            description: task.description,
            points: task.points.toString(),
          ),
        ) {
    descriptionTextController.text = task.description;
    pointsTextController.text = task.points.toString();
  }

  void descriptionChanged(String newDescription) {
    emit(
      state.copyWith(
        description: newDescription,
        status: EditTaskStatus.descriptionChanged,
      ),
    );
  }

  void pointsChanged(String newPoints) {
    emit(
      state.copyWith(
        points: newPoints,
        status: EditTaskStatus.pointsChanged,
      ),
    );
  }

  Future<void> updateTask(int id) async {
    try {
      emit(state.copyWith(status: EditTaskStatus.updatingTask));
      await _databaseService.updateTask(
        Task(
          description: descriptionTextController.text,
          points: int.parse(pointsTextController.text),
          taskId: id,
        ),
      );
      emit(state.copyWith(status: EditTaskStatus.updateTaskSuccess));
    } catch (_) {
      emit(state.copyWith(status: EditTaskStatus.updateTaskFailure));
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      emit(state.copyWith(status: EditTaskStatus.deletingTask));
      await _databaseService.deleteTask(id);
      emit(state.copyWith(status: EditTaskStatus.deleteTaskSuccess));
    } catch (_) {
      emit(state.copyWith(status: EditTaskStatus.deleteTaskFailure));
    }
  }

  @override
  Future<void> close() async {
    descriptionTextController.dispose();
    pointsTextController.dispose();
    super.close();
  }
}
