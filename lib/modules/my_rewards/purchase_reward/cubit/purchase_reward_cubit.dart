import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:my_productive_rewards/models/models.dart';
import 'package:my_productive_rewards/services/database_service.dart';
import 'package:my_productive_rewards/services/persistent_storage_service.dart';
import 'package:my_productive_rewards/utils/iterable_extensions.dart';

part 'purchase_reward_state.dart';

final dateFormat = DateFormat('EEE, MMMM dd, yyyy');

class PurchaseRewardCubit extends Cubit<PurchaseRewardState> {
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final PersistentStorageService _persistentStorageService =
      GetIt.I<PersistentStorageService>();
  final dateTextController =
      TextEditingController(text: dateFormat.format(DateTime.now()));

  late Reward _reward;
  late String _availablePoints;

  PurchaseRewardCubit({
    required Reward reward,
    required String availablePoints,
  }) : super(
          PurchaseRewardState(
            status: PurchaseRewardStatus.initial,
            selectedDate: DateTime.now(),
          ),
        ) {
    _reward = reward;
    _availablePoints = availablePoints;
  }

  void dateChanged(DateTime? newDate) {
    if (newDate != null) {
      dateTextController.text = dateFormat.format(newDate);
    }
    emit(
      state.copyWith(
        selectedDate: newDate,
        status: PurchaseRewardStatus.dateChanged,
      ),
    );
  }

  Future<void> confirmPurchase() async {
    try {
      final reward = PurchasedReward(
        description: _reward.description,
        value: _reward.value,
        link: _reward.link,
        date: dateTextController.text,
      );
      await _databaseService.addPurchasedReward(reward);
      await _databaseService.deleteReward(_reward.rewardId!);
      final rewards = await _databaseService.getPurchasedRewards();

      if (rewards.isNotNullOrEmpty && reward.isInList(rewards)) {
        final remainingPoints = int.parse(_availablePoints) - _reward.value;
        await _persistentStorageService.setString(
          PersistentStorageService.pointsKey,
          remainingPoints.toString(),
        );
        if (_reward.isGoal == 1) {
          await _persistentStorageService.setString(
            PersistentStorageService.goalPointsKey,
            '',
          );
        }
        emit(
          state.copyWith(
            status: PurchaseRewardStatus.success,
            totalPoints: remainingPoints.toString(),
          ),
        );
      } else {
        emit(state.copyWith(status: PurchaseRewardStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(status: PurchaseRewardStatus.failure));
    }
  }

  @override
  Future<void> close() async {
    dateTextController.dispose();
    super.close();
  }
}
