// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/models/models.dart';
import 'package:my_productive_rewards/services/database_service.dart';
import 'package:my_productive_rewards/services/persistent_storage_service.dart';
import 'package:my_productive_rewards/utils/utils.dart';

part 'edit_reward_state.dart';

class EditRewardCubit extends Cubit<EditRewardState> {
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final PersistentStorageService _persistentStorageService =
      GetIt.I<PersistentStorageService>();
  final descriptionTextController = TextEditingController();
  final valueTextController = TextEditingController();
  final linkTextController = TextEditingController();

  late Reward _originalReward;
  EditRewardCubit({required Reward reward})
      : super(
          EditRewardState(
            status: EditRewardStatus.initial,
            description: reward.description,
            value: reward.value.toString(),
            link: reward.link,
            isGoal: reward.isGoal,
          ),
        ) {
    _originalReward = reward;
    descriptionTextController.text = reward.description;
    valueTextController.text = reward.value.toString();
    linkTextController.text = reward.link ?? '';
  }

  void descriptionChanged(String newDescription) {
    emit(
      state.copyWith(
        description: newDescription,
        status: EditRewardStatus.descriptionChanged,
      ),
    );
  }

  void valueChanged(String newValue) {
    emit(
      state.copyWith(
        value: newValue,
        status: EditRewardStatus.valueChanged,
      ),
    );
  }

  void linkChanged(String newLink) {
    emit(
      state.copyWith(
        link: newLink,
        status: EditRewardStatus.linkChanged,
      ),
    );
  }

  void setIsGoal(bool? isGoal) {
    if (isGoal != null) {
      emit(
        state.copyWith(
          isGoal: isGoal ? 1 : 0,
          status: EditRewardStatus.isGoalChanged,
        ),
      );
    }
  }

  Future<void> updateReward(int id) async {
    emit(state.copyWith(status: EditRewardStatus.updatingReward));
    try {
      final goalChanged = state.isGoal != _originalReward.isGoal;
      if (goalChanged) {
        await _persistentStorageService.setString(
          PersistentStorageService.goalPointsKey,
          state.isGoal == 1 ? valueTextController.text : '',
        );

        if (state.isGoal == 1) {
          // Find previous goal and set isGoal to 0
          final rewards = await _databaseService.getRewards();
          if (rewards.isNotNullOrEmpty) {
            final goalReward =
                rewards!.where((reward) => reward.isGoal == 1).toList();
            if (goalReward.length == 1) {
              final goal = goalReward.first;
              await _databaseService.updateReward(
                Reward(
                  description: goal.description,
                  value: goal.value,
                  rewardId: goal.rewardId,
                  link: goal.link,
                ),
              );
            }
          }
        }
      }

      await _databaseService.updateReward(
        Reward(
          description: descriptionTextController.text,
          value: int.parse(valueTextController.text),
          rewardId: id,
          link: linkTextController.text,
          isGoal: state.isGoal,
        ),
      );
      emit(state.copyWith(status: EditRewardStatus.success));
    } catch (_) {
      emit(state.copyWith(status: EditRewardStatus.failure));
    }
  }

  @override
  Future<void> close() async {
    descriptionTextController.dispose();
    valueTextController.dispose();
    linkTextController.dispose();
    super.close();
  }
}
