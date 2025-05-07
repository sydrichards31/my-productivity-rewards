// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/models/task.dart';
import 'package:my_productive_rewards/services/database_service.dart';

part 'add_new_task_state.dart';

class AddNewTaskCubit extends Cubit<AddNewTaskState> {
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final descriptionTextController = TextEditingController();
  final pointsTextController = TextEditingController();
  AddNewTaskCubit()
      : super(
          AddNewTaskState(
            status: AddNewTaskStatus.initial,
            description: '',
            points: '',
          ),
        );

  void descriptionChanged(String newDescription) {
    emit(
      state.copyWith(
        description: newDescription,
        status: AddNewTaskStatus.descriptionChanged,
      ),
    );
  }

  void pointsChanged(String newPoints) {
    emit(
      state.copyWith(
        points: newPoints,
        status: AddNewTaskStatus.pointsChanged,
      ),
    );
  }

  Future<bool> addTask() async {
    try {
      await _databaseService.addTask(
        Task(
          description: descriptionTextController.text,
          points: int.parse(pointsTextController.text),
        ),
      );
      return true;
    } catch (_) {
      emit(state.copyWith(status: AddNewTaskStatus.failure));
      return false;
    }
  }

  @override
  Future<void> close() async {
    descriptionTextController.dispose();
    pointsTextController.dispose();
    super.close();
  }
}
