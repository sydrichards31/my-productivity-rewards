import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:my_productive_rewards/models/reward.dart';
import 'package:my_productive_rewards/services/database_service.dart';
import 'package:my_productive_rewards/services/persistent_storage_service.dart';
import 'package:my_productive_rewards/utils/utils.dart';

part 'add_new_reward_state.dart';

final dateFormat = DateFormat('EEE, MMMM dd, yyyy');

class AddNewRewardCubit extends Cubit<AddNewRewardState> {
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final PersistentStorageService _persistentStorageService =
      GetIt.I<PersistentStorageService>();
  final descriptionTextController = TextEditingController();
  final valueTextController = TextEditingController();
  final linkTextController = TextEditingController();

  AddNewRewardCubit()
      : super(
          AddNewRewardState(
            status: AddNewRewardStatus.initial,
            description: '',
            value: '',
            isGoal: 0,
          ),
        );

  void descriptionChanged(String description) {
    emit(
      state.copyWith(
        description: description,
        status: AddNewRewardStatus.descriptionChanged,
      ),
    );
  }

  void valueChanged(String value) {
    emit(
      state.copyWith(
        value: value,
        status: AddNewRewardStatus.valueChanged,
      ),
    );
  }

  void linkChanged(String link) {
    emit(
      state.copyWith(
        link: link,
        status: AddNewRewardStatus.linkChanged,
      ),
    );
  }

  void setIsGoal(bool? isGoal) {
    if (isGoal != null) {
      emit(
        state.copyWith(
          isGoal: isGoal ? 1 : 0,
          status: AddNewRewardStatus.isGoalChanged,
        ),
      );
    }
  }

  Future<void> addReward() async {
    try {
      if (state.isGoal == 1) {
        await _persistentStorageService.setString(
          PersistentStorageService.goalPointsKey,
          valueTextController.text,
        );
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
      await _databaseService.addReward(
        Reward(
          description: descriptionTextController.text,
          value: int.parse(valueTextController.text),
          link: linkTextController.text,
          isGoal: state.isGoal,
        ),
      );
      emit(state.copyWith(status: AddNewRewardStatus.success));
    } catch (_) {
      emit(state.copyWith(status: AddNewRewardStatus.failure));
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
