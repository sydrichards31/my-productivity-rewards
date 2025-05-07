import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_productive_rewards/models/purchased_reward.dart';
import 'package:my_productive_rewards/models/reward.dart';
import 'package:my_productive_rewards/modules/rewards/rewards_filter_tab.dart';
import 'package:my_productive_rewards/services/database_service.dart';
import 'package:my_productive_rewards/services/persistent_storage_service.dart';

part 'my_rewards_state.dart';

class MyRewardsCubit extends Cubit<MyRewardsState> {
  final DatabaseService _databaseService = GetIt.I<DatabaseService>();
  final PersistentStorageService _persistentStorageService =
      GetIt.I<PersistentStorageService>();
  MyRewardsCubit()
      : super(
          MyRewardsState(
            status: MyRewardsStatus.loading,
            rewards: [],
            points: '',
            purchasedRewards: [],
            selectedTab: RewardsFilterTab.rewards,
          ),
        );

  Future<void> initializeMyRewards() async {
    try {
      final rewards = await _databaseService.getRewards();
      final purchasedRewards = await _databaseService.getPurchasedRewards();
      final points = await _persistentStorageService
          .getString(PersistentStorageService.pointsKey, defaultValue: '0');
      if (rewards == null) {
        emit(state.copyWith(status: MyRewardsStatus.failure));
      }
      emit(
        state.copyWith(
          status: MyRewardsStatus.loaded,
          rewards: rewards,
          points: points,
          purchasedRewards: purchasedRewards,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: MyRewardsStatus.failure));
    }
  }

  Future<void> getRewards() async {
    final rewards = await _databaseService.getRewards();
    emit(
      state.copyWith(
        status: MyRewardsStatus.rewardsUpdated,
        rewards: rewards,
      ),
    );
  }

  void editingReward() {
    emit(
      state.copyWith(
        status: MyRewardsStatus.editingReward,
        rewards: state.rewards,
      ),
    );
  }

  Future<void> deleteReward(int? key) async {
    if (key != null) {
      await _databaseService.deleteReward(key);
      final rewards = await _databaseService.getRewards();
      emit(
        state.copyWith(
          status: MyRewardsStatus.rewardDeleted,
          rewards: rewards,
        ),
      );
    }
  }

  void selectTab(RewardsFilterTab tab) {
    if (state.selectedTab == tab) return;
    emit(
      state.copyWith(
        selectedTab: tab,
      ),
    );
  }
}
