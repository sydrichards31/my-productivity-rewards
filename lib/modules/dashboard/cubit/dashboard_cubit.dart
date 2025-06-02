// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/models/models.dart';
import 'package:my_productive_rewards/services/database_service.dart';
import 'package:my_productive_rewards/services/persistent_storage_service.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final PersistentStorageService _persistentStorageService =
      GetIt.I<PersistentStorageService>();
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final TextEditingController searchBarTextField = TextEditingController();
  DashboardCubit()
      : super(
          DashboardState(
            status: DashboardStatus.loading,
            tasks: [],
            filteredTasks: [],
            points: '',
            goalPoints: '',
          ),
        );

  Future<void> initializeDashboard() async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));
      final tasks = await _databaseService.getTasks();
      final points = await _persistentStorageService
          .getString(PersistentStorageService.pointsKey, defaultValue: '0');
      final goalPoints = await _persistentStorageService.getString(
        PersistentStorageService.goalPointsKey,
      );
      emit(
        state.copyWith(
          status: DashboardStatus.loaded,
          tasks: tasks,
          filteredTasks: tasks,
          points: points,
          goalPoints: goalPoints,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: DashboardStatus.failure));
    }
  }

  Future<void> getTasks() async {
    final tasks = await _databaseService.getTasks();
    List<Task> filteredTasks = List.from(tasks);
    filteredTasks = filteredTasks
        .where(
          (element) => element.description
              .toLowerCase()
              .contains(searchBarTextField.text.toLowerCase()),
        )
        .toList();
    emit(
      state.copyWith(
        status: DashboardStatus.tasksUpdated,
        tasks: tasks,
        filteredTasks: filteredTasks,
      ),
    );
  }

  Future<void> getPoints() async {
    final points = await _persistentStorageService
        .getString(PersistentStorageService.pointsKey);
    emit(state.copyWith(status: DashboardStatus.pointsUpdated, points: points));
  }

  void completedTaskAdded(String points) {
    emit(
      state.copyWith(
        status: DashboardStatus.completedTaskAdded,
        points: points,
      ),
    );
  }

  void taskSearched() {
    List<Task> filteredTasks = List.from(state.tasks);
    filteredTasks = filteredTasks
        .where(
          (element) => element.description
              .toLowerCase()
              .contains(searchBarTextField.text.toLowerCase()),
        )
        .toList();
    emit(
      state.copyWith(
        filteredTasks: filteredTasks,
        status: DashboardStatus.searched,
      ),
    );
  }

  void searchCleared() {
    emit(
      state.copyWith(
        filteredTasks: state.tasks,
        status: DashboardStatus.searchCleared,
      ),
    );
  }
}
