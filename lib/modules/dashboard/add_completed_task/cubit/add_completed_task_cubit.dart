import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:my_productive_rewards/models/models.dart';
import 'package:my_productive_rewards/services/database_service.dart';
import 'package:my_productive_rewards/services/persistent_storage_service.dart';

part 'add_completed_task_state.dart';

final dateFormat = DateFormat('EEE, MMMM dd, yyyy');

class AddCompletedTaskCubit extends Cubit<AddCompletedTaskState> {
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final PersistentStorageService _persistentStorageService =
      GetIt.I<PersistentStorageService>();
  final dateTextController =
      TextEditingController(text: dateFormat.format(DateTime.now()));

  late String _description;
  late int _points;
  AddCompletedTaskCubit({required String description, required int points})
      : super(
          AddCompletedTaskState(
            status: AddCompletedTaskStatus.initial,
            selectedDate: DateTime.now(),
          ),
        ) {
    _description = description;
    _points = points;
  }

  void dateChanged(DateTime? newDate) {
    if (newDate != null) {
      dateTextController.text = dateFormat.format(newDate);
    }
    emit(
      state.copyWith(
        selectedDate: newDate,
        status: AddCompletedTaskStatus.dateChanged,
      ),
    );
  }

  Future<void> addCompletedTask() async {
    try {
      emit(state.copyWith(status: AddCompletedTaskStatus.addingTask));
      await _databaseService.addCompletedTask(
        CompletedTask(
          description: _description,
          points: _points,
          date: dateTextController.text,
        ),
      );
      final stringPoints = await _persistentStorageService
          .getString(PersistentStorageService.pointsKey, defaultValue: '0');
      final points = int.parse(stringPoints);
      final newPoints = points + _points;
      await _persistentStorageService.setString(
        PersistentStorageService.pointsKey,
        newPoints.toString(),
      );
      emit(state.copyWith(status: AddCompletedTaskStatus.success));
    } catch (_) {
      emit(state.copyWith(status: AddCompletedTaskStatus.failure));
    }
  }

  @override
  Future<void> close() async {
    dateTextController.dispose();
    super.close();
  }
}
