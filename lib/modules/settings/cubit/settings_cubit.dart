// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/services/database_service.dart';
import 'package:my_productive_rewards/services/persistent_storage_service.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final PersistentStorageService _persistentStorageService =
      GetIt.I<PersistentStorageService>();
  final goalPointsTextController = TextEditingController();
  SettingsCubit()
      : super(
          SettingsState(
            status: SettingsStatus.initial,
            goalPoints: '',
          ),
        );

  Future<void> initializeSettings() async {
    try {
      final goalPoints = await _persistentStorageService
          .getString(PersistentStorageService.goalPointsKey);
      goalPointsTextController.text = goalPoints;
      emit(
        state.copyWith(
          status: SettingsStatus.loaded,
          goalPoints: goalPoints,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: SettingsStatus.failure));
    }
  }

  Future<void> clearTasks() async {
    await _databaseService.deleteAllTasks();
    emit(state.copyWith(status: SettingsStatus.tasksCleared));
  }

  Future<void> clearTaskLog() async {
    await _databaseService.deleteAllCompletedTasks();
    emit(state.copyWith(status: SettingsStatus.taskLogCleared));
  }

  Future<void> clearRewards() async {
    await _databaseService.deleteAllRewards();
    emit(state.copyWith(status: SettingsStatus.rewardsCleared));
  }

  Future<void> clearPurchasedRewards() async {
    await _databaseService.deleteAllTasks();
    await _databaseService.deleteAllCompletedTasks();
    await _databaseService.deleteAllRewards();
    await _databaseService.deleteAllPurchasedRewards();
    emit(state.copyWith(status: SettingsStatus.allDataCleared));
  }

  Future<void> clearAllData() async {
    await _databaseService.deleteAllPurchasedRewards();
    emit(state.copyWith(status: SettingsStatus.purchasedRewardsCleared));
  }

  @override
  Future<void> close() async {
    goalPointsTextController.dispose();
    super.close();
  }
}
